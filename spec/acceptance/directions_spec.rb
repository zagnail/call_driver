require "rspec_api_documentation_helper"

RSpec.resource "Directions" do

  header "Content-Type", "application/vnd.api+json"
  header "Authorized", "Bearer {access_token}"

  let! :current_user do
    FactoryGirl.create(:user)
  end

  let :access_token do
    Doorkeeper::AccessToken.create!(resource_owner_id: current_user.id)
      
  end

  shared_context "direction parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Must be direction.
    DESC

    let "type" do
      "directions"
    end

    parameter "distance", <<~DESC, scope: :attributes, required: true
      The distance of the direction.
    DESC

    parameter "duration", <<~DESC, scope: :attributes, required: true
      The duration of the direction.
    DESC

    parameter "end-address", <<~DESC, scope: :attributes, required: true
      The end address of the direction.
    DESC

    parameter "start-address", <<~DESC, scope: :attributes, required: true
      The start address of the direction
    DESC

    parameter "end-location", <<~DESC, scope: :attributes, required: true
      The end location of the direction.
    DESC

    parameter "start-location", <<~DESC, scope: :attributes, required: true
      The start location of the direction.
    DESC

    parameter "start-date", <<~DESC, scope: :attributes, required: true
      The start date of the direction.
    DESC

    parameter "cost", <<~DESC, scope: :attributes, required: true
      The cost of the direction.
    DESC
  end

  shared_context "persisted direction" do
    let! :persisted_direction do
      FactoryGirl.create(:direction, user: current_user)
    end

    let :direction_id do
      persisted_direction.id.to_s
    end
  end

  post "/v1/directions" do
    include_context "direction parameters"

    let "distance" do
      212943  
    end

    let "duration" do
      10365
    end

    let "end-address" do
      "Levonaberezhnaya ul., 24, Meleuz, Respublika Bashkortostan, Russia, 453850"
    end

    let "start-address" do
      "ul. Rikharda Zorge, 13, Ufa, Respublika Bashkortostan, Russia, 450059"
    end

    let "end-location" do
      {lat: 52.9603094, lng: 55.919311}
    end

    let "start-location" do
      {lat: 54.7508958, lng: 55.9869267}
    end

    let "start-date" do
      "2017-09-01 13:58:07"
      DateTime.now.advance(hours: 1)
    end

    let "cost" do
      500
    end

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "POST /v1/directions" do
      expect(status).to eq 201
    end
  end

  patch "/v1/directions/:direction_id" do
    include_context "direction parameters"
    include_context "persisted direction"

    parameter "id", "The id of the resource", required: true

    let "id" do
      persisted_direction.id.to_s
    end

    let "cost" do
      1000
    end
    
    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "PATCH /v1/directions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["cost"]).to eq cost
    end
  end

  get "/v1/directions" do
    include_context "persisted direction"

    example_request "GET /v1/directions" do
      expect(status).to eq 200
    end
  end

  get "/v1/directions/:direction_id" do
    include_context "persisted direction"

    example_request "GET /v1/directions/:id" do
      expect(status).to eq 200
    end
  end

  delete "/v1/directions/:direction_id" do
    include_context "persisted direction"

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "DELETE /v1/directions/:id" do
      expect(status).to eq 204
    end
  end
end
