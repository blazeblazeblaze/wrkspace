FactoryBot.define do
  factory :organization do
    contact
    name { Faker::Company.name }
  end
end
