require 'rails_helper'

RSpec.describe User, type: :model do

  describe "association with event" do

    start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

    let(:user) { create :user }
    let!(:event) { create :event, starts_at: start_at, ends_at: end_at, user: user }

    it "has many events" do
      event1 = user.events.build(name: "Amsterdam Light Festival")
      event2 = user.events.build(name: "Eindhoven Glow")

      expect(user.events).to include(event1)
      expect(user.events).to include(event2)
    end

    it "deletes associated events" do
      expect { user.destroy }.to change(Event, :count).by(-1)
    end
  end

  describe "association with registration" do
    let(:guest_user) { create :user, email: "guest@user.com" }
    let(:host_user) { create :user, email: "host@user.com" }

    let!(:event) { create :event, starts_at: '2017-08-28 11:00:00', ends_at: '2017-08-28 17:00:00', user: host_user }
    let!(:registration) { create :registration, event: event, user: guest_user }

    it "has registrations" do
      expect(guest_user.registered_events).to include(event)
    end
  end
end
