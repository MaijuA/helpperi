class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user, :scope => [:post]
  # validates :user_post_owner_or_performer

  def user_post_owner_or_performer
    true
  end
end
