RSpec.describe Direction do
  describe "attributes" do
    %w(distance duration end_address start_address end_location start_location start_date cost).each do |required_attribute|
      it { is_expected.to have_attribute required_attribute }
      it { is_expected.to validate_presence_of required_attribute }
    end
  end

  describe "relationships" do
    it { is_expected.to have_many :journeys }
  end

  describe "validations" do
    it "start_date is after todays date" do
      subject.start_date = DateTime.new(2017, 8, 30, 0, 0)
      subject.valid?
      expect(subject.errors[:start_date]).to include "must be greater than now"
    end
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:direction)).to be_persisted
  end
end
