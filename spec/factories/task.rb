FactoryBot.define do
  factory :task do
    user
    title Faker::HarryPotter.character
  end
end
