require 'rails_helper'

describe "Viewing an individual event" do

  start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
  end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

  let(:event) { create :event, starts_at: start_at, ends_at: end_at }

  it "shows the event's details" do
    visit event_url(event)

    expect(page).to have_text(event.name)
    expect(page).to have_text(event.description)
    expect(page).to have_text(event.location)
    expect(page).to have_text(event.price)
    expect(page).to have_text(event.capacity)
    expect(page).to have_text(event.includes_food ? "Snacks will be available" : "Please bring your own food")
    expect(page).to have_text(event.includes_drinks ? "Drinks will be served!" : "Please bring your own drinks")
    expect(page).to have_text(event.active ? "Yes" : "No")
  end
end
