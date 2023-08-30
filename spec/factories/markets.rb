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
end