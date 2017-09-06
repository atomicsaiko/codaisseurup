require 'rails_helper'

RSpec.describe Event, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

 #  describe "validations" do
 #   it "is invalid without an event name" do
 #     event = Event.new(name: nil)
 #     event.valid?
 #     expect(event.errors).to have_key(:name)
 #   end
 # end
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(500)}
    it { is_expected.to validate_presence_of(:starts_at) }
    it { is_expected.to validate_presence_of(:ends_at) }
  end

  describe "#bargain?" do

    start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

    let(:bargain_event) { create :event, price: 29, starts_at: start_at, ends_at: end_at }
    let(:non_bargain_event) { create :event, price: 100, starts_at: start_at, ends_at: end_at }

    it "returns true if the price is smaller than 30 EUR" do
      expect(bargain_event.bargain?).to eq(true)
      expect(non_bargain_event.bargain?).to eq(false)
    end
  end

  describe ".order_by_price" do

    start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

    let(:most_expensive_event) { create :event, price: 234, starts_at: start_at, ends_at: end_at }
    let(:least_expensive_event) { create :event, price: 1, starts_at: start_at, ends_at: end_at }
    let(:expensive) { create :event, price: 45, starts_at: start_at, ends_at: end_at }

    it "returns the collection of events in ascending order" do
      expect(Event.order_by_price).to eq([least_expensive_event, expensive, most_expensive_event])
    end
  end
end
