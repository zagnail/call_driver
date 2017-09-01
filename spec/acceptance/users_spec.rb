require "rspec_api_documentation_helper"

RSpec.resource "Users" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "user parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Must be users.
    DESC

    let "type" do
      "users"
    end

    parameter "firstname", <<~DESC, scope: :attributes, required: true
      The firstname of the user.
    DESC

    parameter "lastname", <<~DESC, scope: :attributes, required: true
      The lastname of the user.
    DESC

    parameter "email-address", <<~DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    parameter "password", <<~DESC, scope: :attributes, required: true
      The password for the user.
    DESC

    parameter "mobile-phone-number", <<~DESC, scope: :attributes, required: true
      The mobile phone number of the user.
    DESC

  end

  post "/v1/users" do
    include_context "user parameters"

    let "firstname" do
      "Neil"
    end

    let "lastname" do
      "Zag"
    end

    let "email-address" do
      "test@test.com"
    end 

    let "password" do
      "12344321"
    end
 
    let "mobile-phone-number" do
      "+79999999999"
    end

    example_request "POST /v1/users" do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["email-address"]).to eq send("email-address")
    end
  end

  get "/v1/users/:id" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let! :id do
      persisted_user.id.to_s
    end

    example_request "GET /v1/users/:id" do
        expect(status).to eq 200
    end
  end

  get "/v1/users/me" do
    let! :persisted_user do
      FactoryGirl.create(:user, password: "12345678")
    end

    let :access_token do
      Doorkeeper::AccessToken.create!(resource_owner_id: persisted_user.id)
    end

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    example_request "GET /v1/users/me" do
      explanation "The special `me` id for the users resource will return the currently authenticated user."
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["email-address"]).to eq persisted_user.email_address 
    end
  end

  patch "/v1/users/:user_id" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let "user_id" do
      persisted_user.id.to_s
    end

    parameter "id", <<~DESC, required: true
      The id of the user.
    DESC

    let :id do
      persisted_user.id.to_s
    end

    include_context "user parameters"

    let "firstname" do
      "Nail"
    end

    example_request "PATCH /v1/users/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["firstname"]).to eq public_send("firstname")
    end
  end

  get "/v1/users" do
    before do
      2.times do
        FactoryGirl.create(:user)
      end
    end

    example_request "GET /v1/users" do
      expect(status).to eq 200
      users = JSON.parse(response_body)
      expect(users["data"].size).to eq 2
    end
  end
end
