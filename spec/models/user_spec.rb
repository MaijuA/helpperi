require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates the user' do
    user = FactoryGirl.create(:user)

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it 'doesn´t validate user if email is not valid' do
    user = User.create email: 'jkhksajhdka',
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if first name is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: '',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if last name is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: '',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if address is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: '',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if zip code is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if city is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: '',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if phone number is empty' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if phone number is too long' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '05012345678564654654646',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if phone number is too short' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '05012',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if phone number includes letters in wrong places' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: 'ABC1234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if s/he is under 15 yeas old' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '180616A7603',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if zip code is too short' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '0234',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if zip code is too long' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '023450',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if zip code includes a letter' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '0234L',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if zip code includes special character' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '0-340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if social security number is too short' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if social security number is too long' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '01019191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if social security number has wrong check number' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123E',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if social security number has invalid date' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '320191-123W',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'validates user if social security number is from 19th century' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '121299+298K',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(true)
  end

  it 'doesn´t validate user if social security number has invalid century character' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '121299B298K',
                       description: 'oon kiva',
                       password: 'Ihanmitavaan1',
                       password_confirmation: 'Ihanmitavaan1'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if password is on the black list' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'password',
                       password_confirmation: 'password'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if password is on the black list' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'password',
                       password_confirmation: 'password'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if password is less than 8 characters long' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'passwor',
                       password_confirmation: 'passwor'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if password is more than 72 characters long' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: k*73,
                       password_confirmation: k*73

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if first name more than 50 letters' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: k*51,
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if last name more than 50 letters' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: k*51,
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if city more than 50 letters' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: k*51,
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if description more than 2000 letters' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: k*2001,
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if address more than 500 letters' do
    k = 'k'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: k*201,
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if address less than 3 letters' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'ai',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if first name includes a number' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti1',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if last name includes a number' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas1',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'doesn´t validate user if city includes a number' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Matti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo1',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(false)
  end

  it 'validates user if first name includes ääkköset' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Mätti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it 'validates user if first name includes includes å' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Måtti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it 'validates user if first name includes includes á' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Mátti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it 'validates user if first name includes includes â' do
    user = User.create email: Faker::Internet.email,
                       first_name: 'Mätti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan'

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  it 'doesnt save user if language is too long' do
    a = 'a'
    user = User.create email: Faker::Internet.email,
                       first_name: 'Mätti',
                       last_name: 'Mallikas',
                       address: 'Mallitie 3',
                       zip_code: '02340',
                       city: 'Espoo',
                       phone_number: '0501234567',
                       personal_code: '010191-123W',
                       description: 'oon kiva',
                       password: 'ihanmitavaan',
                       password_confirmation: 'ihanmitavaan',
                       language: a*250

    expect(user.valid?).to be(false)
  end

end

