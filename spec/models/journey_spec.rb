RSpec.describe Journey do
  describe "attributes" do
    it { is_expected.to have_attribute :rating }
    
    it { is_expected.to have_attribute :review }

    it { is_expected.to have_attribute :confirmed }

    it { is_expected.to belong_to :user }

    it { is_expected.to belong_to :direction }
  end

  describe "validates" do
    it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }

    it { is_expected.to validate_presence_of :user }

    it { is_expected.to validate_presence_of :direction }

    it "direction user should not be equal to current user" do
      subject = FactoryGirl.create(:journey)
      user = subject.direction.user
      subject.user = user
      subject.valid?
      expect(subject.errors[:user]).to include "should not be equal to direction user"
    end
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:journey)).to be_persisted
  end
end
