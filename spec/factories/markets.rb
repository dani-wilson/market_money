FactoryBot.define do
  factory :market do
    sequence(:id)
    name { Faker::Fantasy::Tolkien.unique.location }
    street { Faker::Address.unique.street_name }
    city { Faker::Address.unique.city }
    county { Faker::Games::DnD.unique.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end

  factory :vendor do
    name { "#{ Faker::Dessert.flavor } #{ Faker::Ancient.primordial } #{ Faker::Creature::Animal }" }
    description { Faker::TvShows::NewGirl.quote }
    contact_name { Faker::Name.unique.name }
    contact_phone { Faker::PhoneNumber.unique }
    credit_accepted { Faker::Boolean }
  end
end