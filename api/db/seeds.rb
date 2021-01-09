# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customers = Customer.create([
  {
    slug: "good-inc",
    name: "Good Inc.",
    contact_email: "info@good.inc",
    signup_date: "2021-01-04",
  },
])
User.create([
  {
    firstname: "Urs",
    lastname: "Elmer",
    email: "urs.elmer@yova.com",
    password: "secret",
  },
  {
    firstname: "Jean",
    lastname: "Dupond",
    email: "jean.dupong@yova.com",
    password: "good!secret",
    customer: customers.first,
  },
])
