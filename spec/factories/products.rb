FactoryBot.define do
  factory :product do
    name { Faker::Device }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 4) }
    category { create(:category) }
  end
end
