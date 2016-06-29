# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# test_user1 = User.find_or_create_by(email: 'mikko.meikalainen@testi.fi') do |user|
#   user.password = 10000000 + rand(10000000)
#   user.first_name = 'Mikko'
#   user.last_name = 'Meikäläinen'
#   user.personal_code = '060588-217L'
#   user.phone_number = '0501234567'
#   user.address = 'Nollakatu 0'
#   user.zip_code = '00000'
#   user.city = 'Helsinki'
#   user.passport_number = false
#   user.confirmed_at = DateTime.now
# end
#
# test_user2 = User.find_or_create_by(email: 'maija.meikalainen@testi.fi') do |user|
#   user.password = 10000000 + rand(10000000)
#   user.first_name = 'Maija'
#   user.last_name = 'Meikäläinen'
#   user.personal_code = '071287-186M'
#   user.phone_number = '0500000000'
#   user.address = 'Nollakatu 0'
#   user.zip_code = '00000'
#   user.city = 'Helsinki'
#   user.passport_number = false
#   user.confirmed_at = DateTime.now
# end

Category.find_or_create_by(name: 'Remontti') do |category|
  category.description =  'Teen kaikki kodin pienet korjausurakat'
  category.image = File.open(File.join(Rails.root, '/seedfiles/renovating.jpg'))
end

Category.find_or_create_by(name: 'Piha&Puutarha') do |category|
  category.description = 'Leikkaan nurmikon, kitken rikkaruohot, hoidan kastelun ja istutukset!'
  category.image = File.open(File.join(Rails.root, '/seedfiles/gardening.jpg'))
end

Category.find_or_create_by( name: 'It&Hifi') do |category|
  category.description = 'Minulta hoituvat niin tietokoneiden kuin televisioiden asennukset'
  category.image = File.open(File.join(Rails.root, '/seedfiles/it.jpg'))
end

Category.find_or_create_by(name: 'Siivous') do |category|
  category.description = 'Imurointi, pölyjen pyyhintä, mattojen tamppaus, ikkunoiden pesu... Kaikki puhdistuu!'
  category.image = File.open(File.join(Rails.root, '/seedfiles/cleaning.jpg'))
end

Category.find_or_create_by(name: 'Opetus') do |category|
  category.description = 'Kärsivällinen opettaja tarjoaa valmennusta aiheeseen kuin aiheeseen'
  category.image = File.open(File.join(Rails.root, '/seedfiles/teaching.jpg'))
end

Category.find_or_create_by(name: 'Lasten hoitoapu') do |category|
  category.description = 'Olen kokenut lasten kaitsija'
  category.image = File.open(File.join(Rails.root, '/seedfiles/childcare.jpg'))
end

Category.find_or_create_by(name: 'Muu hoitoapu') do |category|
  category.description = 'Tarjoan empaattista tukea vanhusten, vammaisten ja vammautuneiden hoitoon'
  category.image = File.open(File.join(Rails.root, '/seedfiles/hands.jpg'))
end

Category.find_or_create_by(name: 'Liikunta&Ulkoilu') do |category|
  category.description = 'Haluatko ulkoilu tai urheiluseuraa? Olen sporttinen kymmenottelija joka on aina valmis liikkumaan!'
  category.image = File.open(File.join(Rails.root, '/seedfiles/sports.jpg'))
end

Category.find_or_create_by(name: 'Ruoka') do |category|
  category.description = 'Kakut, leivokset, ruuat ja keitot isompaan tai pienempään juhlaan'
  category.image = File.open(File.join(Rails.root, '/seedfiles/food.jpg'))
end

Category.find_or_create_by(name: 'Eläimet') do |category|
  category.description = 'Eläinrakas hoitaja kissalle tai koiralle tai vaikka matelijalle'
  category.image = File.open(File.join(Rails.root, '/seedfiles/animals.jpg'))
end

Category.find_or_create_by(name: 'Kuljetus') do |category|
  category.description = 'Luotettavalla pakullani teen kotiinkuljetuksia sekä muuttoja'
  category.image = File.open(File.join(Rails.root, '/seedfiles/truck.jpg'))
end

Category.find_or_create_by(name: 'Muu') do |category|
  category.description = 'Teen kaikkea maan ja taivaan väliltä'
  category.image = File.open(File.join(Rails.root, '/seedfiles/hand_people.jpg'))
end



# Post.find_or_create_by(title: 'Koiranhoitajaa kahdelle saksanpaimenkoiralle') do |post|
#   post.description = 'Perheen kaksi kilttiä saksanpaimenkoiraa tarvitsisivat hoitajaa viikon kesäloman ajaksi'
#   post.user_id = test_user1.id
#   post.price = 200
#   post.ending_date = DateTime.now + 2.weeks
#   post.address = test_user1.address
#   post.zip_code = test_user1.zip_code
#   post.city = test_user1.city
#   post.post_type = "Osto"
#   post.deleted = false
#   #post.category_ids = [Category.find_by(name: 'Eläimet').id]
# end
#
# Post.find_or_create_by(title: 'Puutarhatyöläinen') do |post|
#   post.description = 'Teen puutarhatöitä viikonloppuisin kesälomallani'
#   post.user_id = test_user2.id
#   post.price = 100
#   post.ending_date = DateTime.now + 2.weeks
#   post.address = test_user2.address
#   post.zip_code = test_user2.zip_code
#   post.city = test_user2.city
#   post.post_type = "Myynti"
#   post.deleted = false
#   #post.category_ids = [Category.find_by(name: 'Piha&Puutarha').id]
# end

#PostCategory.create! post_id: post1.id, category_id: animalcare.id
#PostCategory.create! post_id: post2.id, category_id: gardening.id
