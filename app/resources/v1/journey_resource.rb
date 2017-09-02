module V1
  class JourneyResource < BaseResource
    has_one :direction
    has_one :user

    attribute :rating
    attribute :review
    attribute :confirmed

    before_replace_fields :associate_owner
    before_update :authorize_ownerhip!
    before_remove :authorize_ownerhip!

    def associate_owner
      @model.user = context[:current_user]
    end

    def authorize_ownerhip!
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
