FactoryBot.define do
  factory :case do
    name { Faker::Company.bs }
    description { Faker::Company.bs }
    association :assigned_user, factory: :user
    association :contact, factory: :contact
  end
end
