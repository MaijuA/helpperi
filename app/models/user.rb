class User < ActiveRecord::Base
  include CustomValidations

  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format: {
      with: /\d.*[A-Z]|[A-Z].*\d/,
      message: "täytyy sisältää"
  }, if: :password_required?
  validates :first_name, :last_name, :personal_code, :phone_number, :address, :zip_code, :city, presence: true
  validates :phone_number, phone: { possible: true}
  validates :zip_code, format: {
      with: /\A(FI-)?[0-9]{5}\z/,
      message: "ei ole Suomessa kelvollinen"
  }
  validate :hetu

  has_many :posts, dependent: :destroy

  scope :active, -> { where deleted_at:false }
  scope :deleted, -> { where deleted_at:true }

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

  def hetu
    if passport_number.nil? || passport_number == false
      if hetu_valid? personal_code
        errors.add(:personal_code, "palveluun voivat rekisteröityä vain yli 15 vuotiaat") if hetu_too_young? personal_code
      else
        errors.add(:personal_code, "ei ole validi")
      end
    end
  end
end