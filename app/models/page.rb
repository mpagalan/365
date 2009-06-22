class Page < ActiveRecord::Base
  #-----------------------------------------------------
  # named scopes
  # ----------------------------------------------------
  named_scope :latest, :order => "published_on DESC", :limit => 5
  # ----------------------------------------------------
  # plugins
  # ----------------------------------------------------
  has_attached_file :image, :styles => {
                              :fullimage => "x1024",
                              :thumb => "150x150>"
                            },
                            :whiny_thumbnails => true,
                            :default_style => :fullimage,
                            :path => ":rails_root/public/:rails_env/:class/:attachment/:id/:style_:basename.:extension",
                            :url => "/:rails_env/:class/:attachment/:id/:style_:basename.:extension"
  # ----------------------------------------------------
  # validations
  # ----------------------------------------------------
  validates_attachment_presence     :image
  validates_attachment_content_type :image, :content_type => "image/jpeg"
  validates_presence_of             :title, :published_on

end
