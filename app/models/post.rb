class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user

  scope :active, -> { where deleted:false }
  scope :deleted, -> { where deleted:true }
end
