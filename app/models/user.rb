class User < ActiveRecord::Base
  has_secure_password
  validates :username, uniqueness: true, length:{minimum: 2, maximum: 30, message:
      "käyttäjänimen tulee olla 2-30 merkkiä pitkä, eikä se saa olla varattu"}
  validates :password, :format => {:with => /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{4,}\z/, message:
      "salasanan tulee olla vähintään 4 merkkiä pitkä ja sisältää yhden numeron ja yhden ison kirjaimen"}
end
