require 'rails_helper'

describe "user can visit the welcome page" do
  it "and see a dropdown menu" do
    visit '/'
    expect(page).to have_content("Nearest Fuel Station")
    expect(page).to have_content("Search For The Nearest Electric Charging Station")
    expect(page).to have_button("Find Nearest Station")
  end
end

describe "As a user on the welcome page" do
  describe "when I click on turing from the dropdown menu" do
    it "takes me to a page where I can see the closest electric fuel station to me" do

      visit '/'

      select 'Turing'

      click_on 'Find Nearest Station'

      expect(current_path).to eq('/search')

      within '#station-information' do
        expect(page).to have_content("Station Name")
        expect(page).to have_content("Address")
        expect(page).to have_content("Fuel Type")
        expect(page).to have_content("Access Times")
        expect(page).to have_css(".name")
        expect(page).to have_css(".address")
        expect(page).to have_css(".fuel_type")
        expect(page).to have_css(".access_times")
      end

    end
  end
end

# We will be using:
# The NREL alternate fuel stations nearest station API: https://developer.nrel.gov/docs/transportation/alt-fuel-stations-v1/nearest/
# The Google Directions API: https://developers.google.com/maps/documentation/directions/start
# We will be searching for the nearest electric charging station to Turing.
# As a user
# When I visit "/"
# And I select "Turing" from the start location drop down (Note: Use the existing search form)
# And I click "Find Nearest Station"
# Then I should be on page "/search"
# Then I should see the closest electric fuel station to me.
# For that station I should see
# - Name
# - Address
# - Fuel Type
# - Access Times
# I should also see:
# - the distance of the nearest station (should be 0.1 miles)
# - the travel time from Turing to that fuel station (should be 1min)
# - The HTML direction instructions to get to that fuel station
#   "Head <b>southeast</b> on <b>17th St</b> toward <b>Larimer St</b>"
# Bonus points!
# Figure out how to get the directions to display as a string i.e. "Head southeast on 17th St toward Larimer St" instead of as
# clone this repo: https://github.com/turingschool-examples/nearest-fuel-station
#
