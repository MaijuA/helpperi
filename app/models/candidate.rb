class Candidate < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  # scope :accepted_helpers, -> { where denied:false }
  # scope :denied_helpers, -> { where denied:true }

  validates_uniqueness_of :user_id, :scope => :post_id
end
