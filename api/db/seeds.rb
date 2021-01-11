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
    signup_date: "2020-01-04",
  },
  {
    slug: "bad-inc",
    name: "Bad Inc.",
    contact_email: "info@bad.inc",
    signup_date: "2020-01-08",
  },
  {
    slug: "ugly-inc",
    name: "Ugly Inc.",
    contact_email: "info@ugly.inc",
    signup_date: "2020-01-11",
  },
])
User.create([
  {
    firstname: "Urs",
    lastname: "Elmer",
    email: "urs.elmer@yova.ch",
    password: "secret",
  },
  {
    firstname: "Hans",
    lastname: "Siegler",
    email: "hand.siegler@yova.ch",
    password: "notsosecret",
  },
  {
    firstname: "Jean",
    lastname: "Dupond",
    email: "jean.dupond@good.inc",
    password: "good!secret",
    customer: customers.first,
  },
  {
    firstname: "James",
    lastname: "Lane",
    email: "james.lane@good.inc",
    password: "bad!secret",
    customer: customers.second,
  },
  {
    firstname: "Sacha",
    lastname: "Nguyen",
    email: "sacha.ngyuen@ugly.inc",
    password: "ugly!secret",
    customer: customers.third,
  },
])
