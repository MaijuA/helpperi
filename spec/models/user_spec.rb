require 'rails_helper'

RSpec.describe User, type: :model do
  it "saves the user" do
    user_count = User.count
    user = FactoryGirl.create(:user)

    expect(user.valid?).to be(true)
    expect(User.count).to eq(user_count + 1)
  end

  it "doesn't save user if email is not valid" do
    user_count = User.count
    user = User.create email: "jkhksajhdka",
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if first name is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if last name is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if address is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if zip code is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if city is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "",
                       phone_number: "0501234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if phone number is empty" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if phone number is too long" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "05012345678564654654646",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if phone number is too short" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "05012",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if phone number includes letters in wrong places" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "ABC1234567",
                       personal_code: "010191-123W",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

  it "doesn't save user if s/he is under 15 yeas old" do
    user_count = User.count
    user = User.create email: Faker::Internet.email,
                       first_name: "Matti",
                       last_name: "Mallikas",
                       address: "Mallitie 3",
                       zip_code: "02340",
                       city: "Espoo",
                       phone_number: "0501234567",
                       personal_code: "010115A943R",
                       description: "oon kiva",
                       password: "Ihanmitavaan1",
                       password_confirmation: "Ihanmitavaan1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(user_count)
  end

end

