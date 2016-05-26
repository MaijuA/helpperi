class Post < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user

  validates :user_id, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than: 500 }, :allow_blank => true
  scope :active, -> { where deleted:false }
  scope :deleted, -> { where deleted:true }
end
