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
end
