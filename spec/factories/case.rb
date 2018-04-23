FactoryBot.define do
  factory :case do
    name 'John'
    description 'Doe'
    association :assigned_user, factory: :person
    association :contact, factory: :contact
  end
end
