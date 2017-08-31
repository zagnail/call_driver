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
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:journey)).to be_persisted
  end
end
