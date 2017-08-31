FactoryGirl.define do
  factory :direction do
    distance 30075 
    duration 1739
    end_address "Babaevskaya ul., 4, Kumertau, Respublika Bashkortostan, Russia, 453300"
    start_address "Levonaberezhnaya ul., 24, Meleuz, Respublika Bashkortostan, Russia, 453850"
    end_location "{lat: 52.7587305, lng: 55.81016750000001)"
    start_location "{lat: 52.9603094, lng: 55.919311}"
    start_date "2017-08-31 14:41:43"
    cost 50
    association :user, strategy: :build
  end
end
