class Comment < ActiveRecord::Base
  # ----------------------------------------------------
  # associations
  # ----------------------------------------------------
  belongs_to :page
  # ----------------------------------------------------
  # attributes
  # ----------------------------------------------------
  attr_protected :is_spam

  # ----------------------------------------------------
  # validations
  # ----------------------------------------------------
  validates_presence_of             :email, :description, :page_id

  def is_spam!
    is_spam = true
    save
  end
end
