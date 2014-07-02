FactoryGirl.define do
  factory :user do
    name "John"
    sequence(:username) { |i| "john#{i}" }
    password "secret"
  end
end
