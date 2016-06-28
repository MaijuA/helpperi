class Rating < ActiveRecord::Base
  belongs_to :reviewer, :foreign_key => :reviewer_id, class_name: 'User'
  belongs_to :reviewed, :foreign_key => :reviewed_id, class_name: 'User'
  belongs_to :post

  validates_uniqueness_of :reviewer_id, :scope => [:reviewed_id, :post_id]
  validates :review, length: { maximum: 500 }
  validates :score, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }
  validates :reviewer_id, :reviewed_id, :score, :post_id, :presence => true

end
