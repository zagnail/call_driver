module V1
  class JourneyResource < BaseResource
    has_one :direction
    has_one :user

    attribute :rating
    attribute :review
    attribute :confirmed
  end
end
