FactoryBot.define do
  factory :product do
    name { Faker::Device }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number }
  end
end
