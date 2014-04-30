FactoryGirl.define do
  factory :message do
    association :sender, factory: :user
    association :recipient, factory: :user
    subject "Hi"
    body "Hello, world!"

    trait :read do
      read true
    end

    trait :unread do
      read false
    end
  end
end
