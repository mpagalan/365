class Page < ActiveRecord::Base
  # ----------------------------------------------------
  # plugins
  # ----------------------------------------------------
  has_attached_file :image, :styles => { :fullimage => "1024x677>", :thumb => "150x150#"},
                            :default_style => :fullimage,
                            :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"
  # ----------------------------------------------------
  # validations
  # ----------------------------------------------------
  validates_attachment_presence     :image
  validates_attachment_content_type :image, :content_type => "image/jpeg"
  validates_presence_of             :title, :published_on

end
