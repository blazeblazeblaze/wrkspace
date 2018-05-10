FactoryBot.define do
  factory :circle do
    account
    title { Faker::Company.bs }
  end
end
