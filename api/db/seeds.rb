# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

companies = Company.create([
  {name: "Accor", ticker: "AC.PA",},
  {name: "Air Liquide", ticker: "AI.PA",},
  {name: "Airbus", ticker: "AIR.PA",},
  {name: "ArcelorMittal", ticker: "MT.AS",},
  {name: "Atos", ticker: "ATO.PA",},
  {name: "AXA", ticker: "CS.PA",},
  {name: "BNP Paribas", ticker: "BNP.PA",},
  {name: "Bouygues", ticker: "EN.PA",},
  {name: "Capgemini", ticker: "CAP.PA",},
  {name: "Carrefour", ticker: "CA.PA",},
  {name: "Crédit Agricole", ticker: "ACA.PA",},
  {name: "Danone", ticker: "BN.PA",},
  {name: "Dassault Systèmes", ticker: "DSY.PA",},
  {name: "Engie", ticker: "ENGI.PA",},
  {name: "EssilorLuxottica", ticker: "EL.PA",},
  {name: "Hermès", ticker: "RMS.PA",},
  {name: "Kering", ticker: "KER.PA",},
  {name: "L'Oréal", ticker: "OR.PA",},
  {name: "Legrand", ticker: "LR.PA",},
  {name: "LVMH", ticker: "MC.PA",},
  {name: "Michelin", ticker: "ML.PA",},
  {name: "Orange", ticker: "ORA.PA",},
  {name: "Pernod Ricard", ticker: "RI.PA",},
  {name: "PSA", ticker: "UG.PA",},
  {name: "Publicis", ticker: "PUB.PA",},
  {name: "Renault", ticker: "RNO.PA",},
  {name: "Safran", ticker: "SAF.PA",},
  {name: "Saint-Gobain", ticker: "SGO.PA",},
  {name: "Sanofi", ticker: "SAN.PA",},
  {name: "Schneider Electric", ticker: "SU.PA",},
  {name: "Société Générale", ticker: "GLE.PA",},
  {name: "Sodexo", ticker: "SW.PA",},
  {name: "STMicroelectronics", ticker: "STM.PA",},
  {name: "Thales", ticker: "HO.PA",},
  {name: "Total", ticker: "FP.PA",},
  {name: "Unibail-Rodamco-Westfield", ticker: "URW.AS",},
  {name: "Veolia", ticker: "VIE.PA",},
  {name: "Vinci", ticker: "DG.PA",},
  {name: "Vivendi", ticker: "VIV.PA",},
  {name: "Worldline", ticker: "WLN.PA",},
])
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
portfolios = Portfolio.create([
  {
    name: "Porfolio basic",
    amount: 150000,
    customer: customers.first,
  },
  {
    name: "Porfolio custom",
    amount: 150000,
    customer: customers.first,
  },
  {
    name: "Invest Me",
    amount: 183000,
    customer: customers.second,
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
    email: "hans.siegler@yova.ch",
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
companies.each do |company|
  portfolios.each do |portfolio|
    Position.create([
      {
        weight: 0.025,
        portfolio: portfolio,
        company: company,
      }
    ])
  end
end
