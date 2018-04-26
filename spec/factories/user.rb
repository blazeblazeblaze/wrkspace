FactoryBot.define do
  factory :admin, class: 'User' do
    account
    
    admin true
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    email { Faker::Internet.email }
  end
end

FactoryBot.define do
  factory :user do
    account
    
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    email { Faker::Internet.email }
  end
end
