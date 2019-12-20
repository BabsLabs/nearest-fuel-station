require 'rails_helper'

describe "Nearest Station Search" do
  describe "As a user on the welcome page, when I click on Turing from the dropdown menu" do
    it "takes me to a page where I can see the closest electric fuel station to me" do

      visit '/'

      select 'Turing'

      click_on 'Find Nearest Station'

      expect(current_path).to eq('/search')

      within '#station-information' do
        expect(page).to have_content("Station Name:")
        expect(page).to have_content("Address:")
        expect(page).to have_content("Fuel Type:")
        expect(page).to have_content("Access Times:")
        expect(page).to have_css(".name")
        expect(page).to have_css(".address")
        expect(page).to have_css(".fuel_type")
        expect(page).to have_css(".access_times")
      end

    end
  end
end