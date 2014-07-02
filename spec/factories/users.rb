FactoryGirl.define do
  factory :user do
    name "John"
    sequence(:username) { |i| "john#{i}" }
    password "secret"

    trait :fake do
      name { Faker::Name.name }
      username { |u| Faker::Internet.user_name(u.name) }
    end
  end
end
