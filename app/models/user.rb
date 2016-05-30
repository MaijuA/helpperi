class User < ActiveRecord::Base
  include CustomValidations
  mount_uploader :image, ImageUploader

  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates :email, format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "ei ole mahdollinen."
  }
  validates :password, length: { in: 8..72 }, if: :password_required?
  validate :password_black_list, if: :password_required?
  validates :email, :first_name, :last_name, :personal_code, :phone_number, :address, :zip_code, :city, presence: true
  validates :first_name, :last_name, :city, length: { maximum: 50 }
  validates :description, length: { maximum: 2000 }
  validates :address, length: { in: 3..200 }

  validates :first_name, :last_name, :city, format: {
      with: /\A\p{L}+((\s|-)\p{L}+){,3}\z/,
      message: "saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä"
  }
  validates :phone_number, phone: { possible: true}
  validates :zip_code, format: {
      with: /\A(FI-)?[0-9]{5}\z/,
      message: "ei ole Suomessa kelvollinen"
  }
  validates :personal_code, hetu: true, :unless => :passport_number_is_used?

  if :image.present?
    validates_integrity_of :image
    validates_processing_of :image
    validates :image, file_size: { less_than: 5.megabytes }
  end

  has_many :posts, dependent: :destroy

  scope :active, -> { where deleted_at:false }
  scope :deleted, -> { where deleted_at:true }

  def passport_number_is_used?
    !passport_number.nil? && passport_number == true
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

=begin
  def hetu
    if passport_number.nil? || passport_number == false
      if hetu_valid? personal_code
        errors.add(:personal_code, "- palveluun voivat rekisteröityä vain yli 15 vuotiaat") if hetu_too_young? personal_code
      else
        errors.add(:personal_code, "on virheellinen")
      end
    end
  end
=end

  def password_black_list
    blacklist = []
    file = File.join(Rails.root, 'app', 'models', 'concerns', 'blacklist')
    File.open(file) do |f|
      f.each_line do |line|
        blacklist << line[0..(line.size-2)]
      end
    end
    errors.add(:password, "on mustalistattu") if blacklist.include? password
  end

end