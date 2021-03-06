class Page < ActiveRecord::Base
  #-----------------------------------------------------
  # named scopes
  # ----------------------------------------------------
  default_scope :order => "published_on DESC"
  # ----------------------------------------------------
  # associations
  # ----------------------------------------------------
  has_many :comments, :order => "created_at DESC"
  # ----------------------------------------------------
  # plugins
  # ----------------------------------------------------
  has_attached_file :image, :styles => {
                              :fullimage => "x1024",
                              :midimage => "x800",
                              :thumb => "150x150>"
                            },
                            :whiny_thumbnails => true,
                            :default_style => :fullimage,
                            :path => ":rails_root/public/:rails_env/:class/:attachment/:id/:style_:basename.:extension",
                            :url => "/:rails_env/:class/:attachment/:id/:style_:basename.:extension",
                            :storage => :s3
  
  has_attached_file :music, :path => ":rails_root/public/:rails_env/:class/:attachment/:id/:basename.:extension",
                            :url => "/:rails_env/:class/:attachment/:id/:basename.:extension",
                            :storage => :s3
  
  acts_as_state_machine :initial => :pending, :column => :music_state
  state :pending
  state :converting
  state :converted, :enter => :set_new_filename
  state :error
  event :convert do
    transitions :from => :pending, :to => :converting
  end

  event :converted do
    transitions :from => :converting, :to => :converted
  end

  event :failed do
    transitions :from => :converting, :to => :error
  end
  
  # --------------------------------------------------
  # virtual attributes
  # --------------------------------------------------
  cattr_reader :per_page
  attr_reader  :dom_id, :converted_music_path
  @@per_page = 5
  
  # ----------------------------------------------------
  # validations
  # ----------------------------------------------------
  validates_attachment_presence     :image
  validates_attachment_content_type :image, :content_type => "image/jpeg"
  validates_attachment_content_type :music, :content_type => ["application/x-mp3", "audio/mpeg"]
  validates_presence_of             :title, :published_on
  validates_uniqueness_of           :published_on

  # ---------------------------------------------------
  # callbacks
  # ---------------------------------------------------
  #after_create :convert

  # ---------------------------------------------------
  # class methods
  # ---------------------------------------------------
  def self.convert(from_file, to_file)
    system(ffmpeg_command(from_file, to_file))
  end
  
  def self.ffmpeg_command(from_file, to_file)
    command = <<-end_command
      ffmpeg -i #{from_file} -ar 11025 -ab 32  -f mp3 -y #{to_file}
    end_command
  end

  # ---------------------------------------------------
  # instance methods
  # ---------------------------------------------------
  def convert
    return if music.original_filename.nil? || !music.valid?
    self.convert!
    success = system(convert_command)
    if success && $?.exitstatus == 0
      self.converted!
    else
      self.failed!
      flush_failed_flv_delete
    end
  end
  
  def dom_id
   return "#{self.id || rand(100)}-#{created_or_now.strftime('%Y%m%d%s')}"
  end

  protected

  # NB: this method create the ffmpeg command to be used for converting the mp3 to flv
  def convert_command
    @converted_music_path = File.join(File.dirname(music.path), "converted_#{music.basename}.mp3")
    File.open(converted_music_path, 'w')
    unless RAILS_ENV == "test"
      Page.ffmpeg_command(music.path, converted_music_path)
    else
      command = "echo ok"
    end
    command.gsub!(/\s+/, " ")
  end

  def flush_failed_flv_delete
    logger.info("[paperclip] Deleting converted mp3 for #{music.basename}.mp3")
    puts converted_music_path
    begin
      logger.info("[paperclip] -> #{converted_music_path}")
      FileUtils.rm(converted_music_path) if File.exist?(converted_music_path)
    rescue Errno::ENOENT => e
      # ignore file-not-found, let everything else pass
    end
  end

  # NB: this method is used to update the music_file_name with the converted flv file
  def set_new_filename
    update_attribute(:music_file_name, "converted_#{music.basename}.mp3")
  end

  private
  def created_or_now
    self.created_at || Time.now
  end
end
