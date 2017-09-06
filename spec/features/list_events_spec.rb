require 'rails_helper'

describe "Current user viewing the list of events" do

  start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
  end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

  before { login_as user }

  let(:user) { create :user, email: "current@user.com" }
  let(:another_user) { create :user, email: "another@user.com" }

  let!(:event1) { create :event, name: "Event 1", user: user, starts_at: start_at, ends_at: end_at }
  let!(:event2) { create :event, name: "Event 2", user: user, starts_at: start_at, ends_at: end_at }
  let!(:event3) { create :event, name: "Another event", user: another_user, starts_at: start_at, ends_at: end_at }

  it "shows all his events" do
    visit events_url

    expect(page).to have_text("Event 1")
    expect(page).to have_text("Event 2")
  end

  it "does not show other users events" do
    visit events_url

    expect(page).not_to have_text("Another event")
  end

end
