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

    before_replace_fields :associate_owner
    before_update :authorize_ownership!
    before_remove :authorize_ownership!

    def associate_owner
      @model.user = context[:current_user]
    end

    def authorize_ownership!
      raise Forbidden unless owned_by_current_user?
    end

    class << self
      def creatable_fields(context)
        super - [:user]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    private
      def owned_by_current_user? 
        @model.user == context[:current_user]
      end
  end
end
