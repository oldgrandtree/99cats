# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create!([
  {age: 2, birth_date: "2013-12-23", color: "brown", name: "fluffy", sex: "F"},
  {age: 5, birth_date: "2010-12-03", color: "orange", name: "bert", sex: "M"},
  {age: 7, birth_date: "2009-05-05", color: "white", name: "Sennacy2", sex: "F"}
  ]
)

requests = CatRentalRequest.create!([
  {cat_id: 1, start_date: "2015-12-23", end_date: "2015-12-25"},
  {cat_id: 1, start_date: "2015-12-24", end_date: "2015-12-26"},
  {cat_id: 1, start_date: "2016-12-24", end_date: "2016-12-26"},
  {cat_id: 2, start_date: "2015-12-24", end_date: "2015-12-26"},
  ]
)

users = User.create!([
  {user_name: "levi" , password: "pizzapizza"},
  {user_name: "josh" , password: "mypassword"},
  {user_name: "tommy", password: "security"  }
])