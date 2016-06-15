# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_user1 = User.create email: 'mikko.meikalainen@testi.fi', password: 10000000 + rand(10000000),first_name: 'Mikko', last_name: 'Meikäläinen', personal_code: '060588-217L', phone_number: '0501234567', address: 'Nollakatu 0', zip_code: '00000', city: 'Helsinki', passport_number: false, confirmed_at: DateTime.now
test_user2 = User.create first_name: 'Maija', last_name: 'Meikäläinen', password: 10000000 + rand(10000000), personal_code: '071287-186M', phone_number: '0500000000', address: 'Nollakatu 0', zip_code: '00000', city: 'Helsinki', passport_number: false, confirmed_at: DateTime.now

renovating = Category.create name: 'Remontti', description:'Teen kaikki kodin pienet korjausurakat'
renovating.image = File.open(File.join(Rails.root, '/seedfiles/renovating.jpg'))
renovating.save
gardening = Category.create name: 'Piha&Puutarha', description:'Leikkaan nurmikon, kitken rikkaruohot, hoidan kastelun ja istutukset!'
gardening.image = File.open(File.join(Rails.root, '/seedfiles/gardening.jpg'))
gardening.save
it_supporting = Category.create name: 'It&Hifi', description:'Minulta hoituvat niin tietokoneiden kuin televisioiden asennukset'
it_supporting.image = File.open(File.join(Rails.root, '/seedfiles/it.jpg'))
it_supporting.save
cleaning = Category.create name: 'Siivous', description:'Imurointi, pölyjen pyyhintä, mattojen tamppaus, ikkunoiden pesu... Kaikki puhdistuu!'
cleaning.image = File.open(File.join(Rails.root, '/seedfiles/cleaning.jpg'))
cleaning.save
teaching = Category.create name: 'Opetus', description:'Kärsivällinen opettaja tarjoaa valmennusta aiheeseen kuin aiheeseen'
teaching.image = File.open(File.join(Rails.root, '/seedfiles/teaching.jpg'))
teaching.save
childcare = Category.create name: 'Lasten hoitoapu', description:'Olen kokenut lasten kaitsija'
childcare.image = File.open(File.join(Rails.root, '/seedfiles/childcare.jpg'))
childcare.save
carejob = Category.create name: 'Muu hoitoapu', description:'Tarjoan empaattista tukea vanhusten, vammaisten ja vammautuneiden hoitoon'
carejob.image = File.open(File.join(Rails.root, '/seedfiles/hands.jpg'))
carejob.save
outdoors = Category.create name: 'Liikunta&Ulkoilu', description:'Haluatko ulkoilu tai urheiluseuraa? Olen sporttinen kymmenottelija joka on aina valmis liikkumaan!'
outdoors.image = File.open(File.join(Rails.root, '/seedfiles/sports.jpg'))
outdoors.save
food = Category.create name: 'Ruoka', description:'Kakut, leivokset, ruuat ja keitot isompaan tai pienempään juhlaan'
food.image = File.open(File.join(Rails.root, '/seedfiles/sports.jpg'))
food.save
animalcare = Category.create name: 'Eläimet', description:'Eläinrakas hoitaja kissalle tai koiralle tai vaikka matelijalle'
animalcare.image = File.open(File.join(Rails.root, '/seedfiles/animals.jpg'))
animalcare.save
moving = Category.create name: 'Kuljetus', description:'Luotettavalla pakullani teen kotiinkuljetuksia sekä muuttoja'
moving.image = File.open(File.join(Rails.root, '/seedfiles/truck.jpg'))
moving.save
other = Category.create name: 'Muu', description:'Teen kaikkea maan ja taivaan väliltä'
other.image = File.open(File.join(Rails.root, '/seedfiles/hand_people.jpg'))
other.save

post1 = Post.create title: 'Koiranhoitajaa kahdelle saksanpaimenkoiralle', description: 'Perheen kaksi kilttiä saksanpaimenkoiraa tarvitsisivat hoitajaa viikon kesäloman ajaksi', user_id: test_user1.id, price: 200, ending_date: DateTime.now + 2.weeks, address: test_user1.address, zip_code: test_user1.zip_code, city: test_user1.city, post_type: "Osto"
post2 = Post.create title: 'Puutarhatyöläinen', description: 'Teen puutarhatöitä viikonloppuisin kesälomallani', user_id: test_user2.id, price: 0, ending_date: DateTime.now + 2.months, address: test_user2.address, zip_code: test_user2.zip_code, city: test_user2.city, radius: 6, post_type: "Myynti"


PostCategory.create post_id: post1.id, category_id: animalcare.id
PostCategory.create post_id: post2.id, category_id: gardening.id
