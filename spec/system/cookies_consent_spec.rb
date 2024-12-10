require "rails_helper"

describe "Cookies consent" do
  before { Setting["feature.cookies_consent"] = true }

  context "Banner consent" do
    scenario "Hides the banner when accepting essential cookies and for consecutive visits" do
      visit root_path

      expect(cookie_by_name("cookies_consent")).to be nil

      within ".cookies-consent-banner" do
        click_button "Accept essential cookies"
      end

      expect(cookie_by_name("cookies_consent")[:value]).to eq "essential"
      expect(page).not_to have_content "Cookies policy"

      refresh

      expect(page).not_to have_content "Cookies policy"
    end
  end

  context "Management modal" do
    scenario "Allow users access to cookies management modal" do
      visit root_path

      within ".cookies-consent-banner" do
        click_button "Manage cookies"
      end

      expect(page).to have_css "h2", text: "Cookies management"
    end
  end
end
