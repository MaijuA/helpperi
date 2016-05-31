class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :user_id, :type, :title, :zip_code, :city, :price, :ending_date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than: 500 }
  validates :type, :inclusion=> { :in => ["myynti", "osto"] }
  validates :title, length: { in: 4..50 }
  validates :address, length: { in: 3..200 } if :type == "osto"

  validates :city, format: {
      with: /\A\p{L}+((\s|-)\p{L}+){,3}\z/,
      message: "saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä"
  }
  validates :zip_code, format: {
      with: /\A(FI-)?[0-9]{5}\z/,
      message: "ei ole Suomessa kelvollinen"
  }

  validates :ending_date, dateinfuture: true
  validates :description, length: { maximum: 2000 }
  validates :radius, numericality: {greater_than_or_equal_to: 0, less_than: 200 } if :type == "myynti"

  if :image.present?
    validates_processing_of :image
    validates :image, :file_size => {
        :maximum => 5.megabytes.to_i
    }
  end


  scope :active, -> { where deleted:false }
  scope :deleted, -> { where deleted:true }
end
