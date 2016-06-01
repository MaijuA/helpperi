class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, -> {distinct}, through: :post_categories
end
