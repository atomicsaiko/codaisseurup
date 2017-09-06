require 'rails_helper'

describe "Navigating events" do
  before { login_as user }

  start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
  end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

  let(:user) { create :user }
  let!(:event) { create :event, starts_at: start_at, ends_at: end_at, user: user }

  it "allows navigation from the detail page to the listing page" do
    visit event_url(event) # To event detail page

    click_link "Back"

    expect(current_path).to eq(events_path)
  end

  it "allows navigation from the events page to the detail page" do
    visit events_url # To index of events (notice plural form)

    click_link "View"

    expect(current_path).to eq(event_path(event))
  end
end
