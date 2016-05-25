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
  validate :hetu

  def hetu
    if !hetu_valid? personal_code
      errors.add(:personal_code, "ei ole validi") unless hetu_valid? personal_code
    else
      errors.add(:personal_code, "- Palveluun voivat rekisteröityä vain yli 15 vuotiaat") if hetu_too_young? personal_code
    end
  end
end