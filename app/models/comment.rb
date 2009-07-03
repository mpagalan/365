class Comment < ActiveRecord::Base
  # ----------------------------------------------------
  # validations
  # ----------------------------------------------------
  validates_presence_of             :email, :description
end
