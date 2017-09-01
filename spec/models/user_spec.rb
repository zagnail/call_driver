RSpec.describe User do
  %w(firstname lastname email_address mobile_phone_number).each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end

  it "validates the uniquesness of email_address" do
    original = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user, email_address: original.email_address)
    duplicate.valid?
    expect(duplicate.errors[:email_address]).to include "has already been taken"
  end


  it "validates the uniqueness of mobile_phone_number" do
    original = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user, mobile_phone_number: original.mobile_phone_number)
    duplicate.valid?
    expect(duplicate.errors[:mobile_phone_number]).to include "has already been taken"
  end

  it "persists a password digest based on the password that can be used for authentication" do
    password = "password"
    subject = FactoryGirl.create(:user, password: password)
    expect(subject.authenticate(password)).to eq subject
  end

  it "can create a user without a password" do
    expect{ FactoryGirl.create(:user) }.not_to raise_error
  end

  it { is_expected.to have_many :directions }

  it { is_expected.to have_many :journeys }
end
