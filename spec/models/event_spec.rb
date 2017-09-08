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

  describe "association with user" do
    let(:user) { create :user }

    it "event belongs to a user" do
      event = user.events.build(name: "Amsterdam Light Festival")

      expect(event.user).to eq(user)
    end

    # OR, go the shoulda way:

    it { is_expected.to belong_to :user}
    # and an added bonus: test the themes association in one line as well:
    it { is_expected.to have_and_belong_to_many :categories }
  end

  describe "association with categorie" do

    start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

    let(:event) { create :event, starts_at: start_at, ends_at: end_at }

    let(:categorie1) { create :category, name: "Food", events: [event] }
    let(:categorie2) { create :category, name: "Games", events: [event] }
    let(:categorie3) { create :category, name: "Travel", events: [event] }

    it "has categories" do
      expect(event.categories).to include(categorie1)
      expect(event.categories).to include(categorie2)
      expect(event.categories).to include(categorie3)
    end
  end

  describe "association with registration" do
    let(:guest_user) { create :user, email: "guest@user.com" }
    let(:host_user) { create :user, email: "host@user.com" }

    let!(:event) { create :event, starts_at: '2017-08-28 11:00:00', ends_at: '2017-08-28 17:00:00', user: host_user }
    let!(:registration) { create :registration, event: event, user: guest_user }

    it "has guests" do
      expect(event.guests).to include(guest_user)
    end
  end
end
