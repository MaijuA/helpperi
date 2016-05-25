class User < ActiveRecord::Base
  include CustomValidations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format: {
                with: /\d.*[A-Z]|[A-Z].*\d/,
                message: "has to contain one number and one upper case letter"
            }, if: :password_required?
  validates :first_name, :last_name, :personal_code, :phone_number, :address, :zip_code, :city, presence: true
  validates :phone_number, phone: { possible: true}
  validate :hetu

  def hetu
    errors.add(:personal_code, "ei ole validi") unless hetu_valid?(personal_code)
  end
end