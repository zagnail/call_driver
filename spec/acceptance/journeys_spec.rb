require "rspec_api_documentation_helper"

RSpec.resource "Journeys" do
  header "Content-Type", "application/vnd.api+json"
  header "Authorized", "Bearer {access_token}"

  let! :current_user do
    FactoryGirl.create(:driver)
  end

  let :access_token do
    Doorkeeper::AccessToken.create!(resource_owner_id: current_user.id)
  end

  shared_context "journey parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Must be journeys.
    DESC

    let "type" do
      "journeys"
    end

    parameter "direction", <<~DESC, scope: :relationships, required: true
      The direction of the journey.
    DESC

    parameter "rating", <<~DESC, scope: :attributes
      The rating of the driver.
    DESC

    parameter "review", <<~DESC, scope: :attributes
      The review of the driver.
    DESC

    parameter "confirmed", <<~DESC, scope: :attributes
      The confirmed of the journey.
    DESC
  end

  shared_context "persisted journey" do
    let! :persisted_journey do
      FactoryGirl.create(:journey, user: current_user)
    end

    let :journey_id do
      persisted_journey.id.to_s
    end
  end

  post "/v1/journeys" do
    include_context "journey parameters"

    let! :persisted_direction do
      FactoryGirl.create(:direction)
    end

    let "direction" do
      {
        data: {
          id: persisted_direction.id.to_s,
          type: "directions"
        }
      }
    end

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "POST /v1/journeys" do
      puts response_body
      expect(status).to eq 201
    end
  end

  patch "/v1/journeys/:journey_id" do
    include_context "journey parameters"
    include_context "persisted journey"

    parameter "id", "The id of the resource", required: true

    let "id" do
      persisted_journey.id.to_s
    end

    let "rating" do
      1
    end

    let "review" do
      "This driver is bad to drive!!"
    end

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "PATCH /v1/journeys/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["rating"]).to eq rating
    end
  end

  get "/v1/journeys/:journey_id" do
    include_context "persisted journey"

    example_request "GET /v1/journeys/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/journeys" do
    include_context "persisted journey"

    example_request "GET /v1/journeys" do
      expect(status).to eq 200
    end
  end

  delete "/v1/journeys/:journey_id" do
    include_context "persisted journey"

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "DELETE /v1/journeys/:id" do
      expect(status).to eq 204
    end
  end
end
