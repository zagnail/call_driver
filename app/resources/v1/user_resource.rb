module V1
  class UserResource < BaseResource
    attribute :firstname
    attribute :lastname
    attribute :email_address
    attribute :mobile_phone_number
    attribute :password

    def fetchable_fields
      super - [:password]
    end
  end
end
