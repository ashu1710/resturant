# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
city = City.create name: 'Ahmedabad'
area = Area.create name: 'Bapunagar', city_id: city.id
Admin.create(email: 'test@gmail.com', password: 321321, city_id: city.id, area_id: area.id)