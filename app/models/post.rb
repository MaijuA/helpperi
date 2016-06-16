class Post < ActiveRecord::Base
  acts_as_reader
  belongs_to :user
  has_many :post_categories
  has_many :categories, -> {distinct}, through: :post_categories
  has_many :accepted_candidates, -> { where denied: false }, class_name: 'Candidate'
  has_many :denied_candidates, -> { where denied: true }, class_name: 'Candidate'
  has_many :helpers, through: :accepted_candidates, source: :user
  has_many :denied_helpers, through: :denied_candidates, source: :user
  has_many :ratings

  mount_uploader :image, ImageUploader

  before_save do
    self.title = title.to_s.capitalize
    self.address = address.to_s.capitalize
    self.city = city.to_s.capitalize
  end

  validates :user_id, :post_type, :zip_code, :city, :price, :ending_date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than: 500 }
  validates :post_type, :inclusion=> { :in => ['Myynti', 'Osto'] }
  validates :title, length: { in: 4..30 }
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

  validates_processing_of :image, if: :image_is_set?
  validates_integrity_of :image, if: :image_is_set?
  validates :image, :file_size => {
      :maximum => 5.megabytes.to_i
  }, if: :image_is_set?

  def seller?
    post_type == 'Myynti'
  end

  def buyer?
    post_type == 'Osto'
  end

  def image_is_set?
    self.image.file != nil
  end

  def performer
    unless self.doer_id.nil?
      User.find self.doer_id
    end
  end

  scope :active, -> { where(deleted:false).where(doer_id:nil) }
  scope :accepted, -> { where(deleted:false).where.not(doer_id:nil) }
  scope :deleted, -> { where deleted:true }
  scope :buying, -> { where post_type:'Osto'}
  scope :selling, -> { where post_type:'Myynti'}
  scope :valid, lambda{ where("ending_date >= ?", Date.today) }
  scope :others, -> (current_user) { where("user_id != ?", current_user)}
  scope :expired, lambda{ where("ending_date < ?", Date.today) }

  def category_to_take_image_from
    if self.categories != nil && self.categories.size == 1
      return categories[0]
    else
      misc = Category.select { |category| category.name == 'Muu' }
      return misc[0] unless misc.empty?
    end
    return self
  end
end
