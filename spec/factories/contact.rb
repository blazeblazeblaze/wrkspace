FactoryBot.define do
  factory :contact do
    account
    association :contactable, factory: :person
  end
end
