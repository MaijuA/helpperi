class Rating < ActiveRecord::Base
  belongs_to :reviewer, :foreign_key => :reviewer_id, class_name: 'User'
  belongs_to :reviewed, :foreign_key => :reviewed_id, class_name: 'User'
  belongs_to :post

  validates_uniqueness_of :reviewer_id, :scope => [:reviewed_id, :post_id]
  validates :review, length: { maximum: 500 }
  validates :score, :numericality => { :in => 1..3 }

end
