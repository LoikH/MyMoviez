require "rails_helper"

RSpec.describe "PagesManagement", type: :feature do

  describe "Visit #home" do
    it "title is Tuto | Accueil" do
      visit "/pages/home/"
      expect(page).to have_selector("title", :text => "Tuto | Accueil", :visible => false)
    end
  end

  describe "Visit #contact" do
    it "title is Tuto | Contact" do
      visit "/pages/contact/"
      expect(page).to have_selector("title", :text => "Tuto | Contact", :visible => false)
    end
  end

  describe "Visit #about" do
    it "title is Tuto | À Propos" do
      visit "/pages/about/"
      expect(page).to have_selector("title", :text => "Tuto | À Propos", :visible => false)
    end
  end

end