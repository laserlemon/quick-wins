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

    trait :fake do
      association :sender, factory: [:user, :fake]
      association :recipient, factory: [:user, :fake]
      body { Faker::Lorem.paragraphs.join("\n\n") }
      subject { Faker::Company.bs.sub(/^./, &:upcase) }
      read { rand(2) == 1 }
    end
  end
end
