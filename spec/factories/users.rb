FactoryGirl.define do
  factory :user do
    firstname "Neil"
    lastname "Zag"
    sequence(:email_address) { |n| "test-#{n}@test.com" }
    sequence(:mobile_phone_number) { |n| "+7999999999#{n}" }
  end
end
