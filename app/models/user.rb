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

  def hetu
    if passport_number == false and !hetu_valid? personal_code
      errors.add(:personal_code, "ei ole validi")
    elsif passport_number == false and hetu_too_young? personal_code
      errors.add(:personal_code, "- palveluun voivat rekisteröityä vain yli 15 vuotiaat")
    end
  end
end