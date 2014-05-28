# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create!([
  {age: 2, birth_date: "December 2nd", color: "brown", name: "fluffy", sex: "F"},
  {age: 5, birth_date: "December 12th", color: "orange", name: "bert", sex: "M"},
  {age: 7, birth_date: "May 8th", color: "white", name: "Sennacy2", sex: "F"},
  ])