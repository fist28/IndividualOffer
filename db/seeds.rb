Faker::Config.locale = 'pl'

p '-- Seed start --'

unless User.any?
  p 'Create default user'
  user = User.create do |u|
    u.email   = "john@example.com"
    u.password  = "password"
  end
end

unless Company.any?
  p 'Create default company'
  master_company = Company.create! do |c|
    c.name        = Faker::Company.name
    c.nip         = Faker::Number.number(10)
    c.address     = Faker::Address.street_address
    c.city        = Faker::Address.city
    c.post_code   = Faker::Address.postcode
    c.description = Faker::Lorem.sentence
    c.user_id     = User.first
    c.contact     = "#{Faker::PhoneNumber.phone_number} - #{Faker::Name.first_name}"
  end

  p 'Create more companies'
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
end

p '-- Seed stop --'
