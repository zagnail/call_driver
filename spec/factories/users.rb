FactoryGirl.define do
  factory :user do
    firstname "Neil"
    lastname "Zag"
    sequence(:email_address) { |n| "test-#{n}@test.com" }
    sequence(:mobile_phone_number) { |n| "+7999999999#{n}" }
  end

  factory :driver, class: User do
    firstname "Michael"
    lastname "Schumacher"
    email_address "schumacher@test.com"
    mobile_phone_number "+11111111111"
  end
end
