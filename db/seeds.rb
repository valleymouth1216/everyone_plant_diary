# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Tag.create([
    { name: '野菜' },
    { name: '果物' },
    { name: '花'},
    { name: '木'},
    { name: 'その他'}
    ])

Admin.create!(
  email: "admin@a",
  password: "123456"
)

Customer.create!(
  email: "aa@a",
  password: "123456",
  name:"令和"
)