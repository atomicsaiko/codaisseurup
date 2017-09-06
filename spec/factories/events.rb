FactoryGirl.define do
  factory :event do
    name              "Amsterdam Pasta Festival"
    description       { Faker::Lorem.sentence(40) }
    location          { Faker::Address.city }
    price             { Faker::Commerce.price }
    capacity          1000
    includes_food     true
    includes_drinks   false
    starts_at         2
    ends_at           5
    user              { build(:user) }

    trait :active do
      active true
    end

    trait :inactive do
      active false
    end
  end
end
