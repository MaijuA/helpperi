class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_categories
  has_many :categories, -> {distinct}, through: :post_categories
  mount_uploader :image, ImageUploader

  validates :user_id, :post_type, :zip_code, :city, :price, :ending_date, presence: true
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

  scope :active, -> { where deleted:false }
  scope :deleted, -> { where deleted:true }
  scope :buying, -> { where post_type:'Osto'}
  scope :selling, -> { where post_type:'Myynti'}
  scope :valid, lambda{ where("ending_date >= ?", Date.today) }
  scope :expired, lambda{ where("ending_date < ?", Date.today) }

  searchable do
    text :title, :as => :title_textp
    text :description, :as => :description_textp
    text :post_type
    text :zip_code
    text :city
    integer :price
    integer :user_id
    integer :radius
    time :created_at
    time :ending_date
    boolean :deleted
  end

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
