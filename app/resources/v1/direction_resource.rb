module V1
  class DirectionResource < BaseResource
    attribute :distance
    attribute :duration
    attribute :end_address
    attribute :start_address
    attribute :end_location
    attribute :start_location
    attribute :start_date
    attribute :cost

    has_one :user

  end
end
