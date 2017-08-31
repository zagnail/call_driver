FactoryGirl.define do
  factory :journey do
    association :direction, strategy: :build
    association :user, factory: :driver, strategy: :build
    rating 4
    review "This driver is the awesome!!"
    confirmed true
  end
end
