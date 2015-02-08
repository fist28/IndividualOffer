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
    c.user_id     = user.id
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

  p 'Create Product Categories'
  master_company.categories.create!(name: 'Cat 1')
  master_company.categories.create!(name: 'Cat 2')
  master_company.categories.create!(name: 'Cat 3')
  master_company.categories.create!(name: 'Cat 4')
  master_company.categories.create!(name: 'Cat 5')

  p 'Create products'
  (1..50).each do |i|
    master_company.products.create do |p|
      unit = Product::UNIT.sample
      p.name = Faker::App.name
      p.unit = unit
      p.price = rand * (50-10) + 10
      p.volume_container = Random.rand(20)
      p.volume_type = Product::VOLUME_TYPE.sample
      p.quantity_container = Random.rand(20) if unit == 'package'
      p.vat = 11
      p.category = Category.find(master_company.categories.map(&:id).sample)
    end
  end

end

p '-- Seed stop --'
