# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Faker::Config.locale = 'pl-PL'

master_company = Company.create! do |c|
  c.name        = Faker::Company.name
  c.nip         = Faker::Number.number(10)
  c.address     = Faker::Address.street_address
  c.city        = Faker::Address.city
  c.post_code   = Faker::Address.postcode
  c.description = Faker::Lorem.sentence
  c.contact     = "#{Faker::PhoneNumber.phone_number} - #{Faker::Name.first_name}"
end

(1..10).each do |i|
  Company.create! do |c|
    c.name        = Faker::Company.name
    c.nip         = Faker::Number.number(10)
    c.address     = Faker::Address.street_address
    c.city        = Faker::Address.city
    c.post_code   = Faker::Address.postcode
    c.description = Faker::Lorem.sentence
    c.contact     = "#{Faker::PhoneNumber.phone_number} - #{Faker::Name.first_name}"
    c.company_id  = master_company.id
  end
end