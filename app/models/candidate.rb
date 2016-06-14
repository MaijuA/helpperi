class Candidate < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  acts_as_readable :on => :created_at
  acts_as_readable :on => :updated_at

  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, :scope => :post_id
end
