class Rating < ActiveRecord::Base
  ratyrate_rateable :user_id
  belongs_to post
  belongs_to user
end
