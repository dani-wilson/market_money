FactoryBot.define do
  factory :vendor do
    sequence(:id)
    name { "#{ Faker::Dessert.flavor } #{ Faker::Ancient.primordial } #{ Faker::Creature::Animal.name.capitalize }" }
    description { Faker::TvShows::NewGirl.quote }
    contact_name { Faker::Name.unique.name }
    contact_phone { Faker::PhoneNumber.cell_phone }
    credit_accepted { Faker::Boolean }
  end
end