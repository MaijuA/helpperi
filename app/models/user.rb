class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_secure_password
  validates :username, uniqueness: true, length:{minimum: 2, maximum: 30, message:
      "tulee olla 2-30 merkkiä pitkä, eikä se saa olla varattu"}
  validates :password, :format => {:with => /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{4,}\z/, message:
      "tulee olla vähintään 4 merkkiä pitkä ja sisältää yhden numeron ja yhden ison kirjaimen"}
end
