class Post < ActiveRecord::Base
  belongs_to :user
  has_many :categories, through: :post_categories
  mount_uploader :image, ImageUploader
  #before_validation :default_image

  #private
  #def default_image
  #  self.image = 'http://res.cloudinary.com/helpperi/image/upload/v1464594387/sjunnwld4cmc3nawoowb.jpg'
  #end

  validates :user_id, :post_type, :title, :zip_code, :city, :price, :ending_date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than: 500 }
  validates :post_type, :inclusion=> { :in => ['Myynti', 'Osto'] }
  validates :title, length: { in: 4..50 }
  validates :address, length: { in: 3..200 }, if: :buyer?
  # validates :categories, length: { maximum: 5 }

  validates :city, format: {
      with: /\A\p{L}+((\s|-)\p{L}+){,3}\z/,
      message: 'saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  }
  validates :zip_code, format: {
      with: /\A(FI-)?[0-9]{5}\z/,
      message: 'ei ole Suomessa kelvollinen'
  }

  validates :ending_date, date_in_future: true
  validates :description, length: { maximum: 2000 }
  validates :radius, numericality: {greater_than_or_equal_to: 0, less_than: 200 }, if: :seller?

  if :image.present?
    validates_processing_of :image
    validates :image, :file_size => {
        :maximum => 5.megabytes.to_i
    }
  end

  def seller?
    post_type == 'Myynti'
  end

  def buyer?
    post_type == 'Osto'
  end

  scope :active, -> { where deleted:false }
  scope :deleted, -> { where deleted:true }
  scope :buying, -> { where post_type:'Osto'}
  scope :selling, -> { where post_type:'Myynti'}
end
