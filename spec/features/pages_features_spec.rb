require "rails_helper"

RSpec.describe "PagesManagement", type: :feature do

  before(:each) do
    @base_title = "MyMoviez"
  end

  describe "Visit #home" do
    it "title is MyMoviez | Accueil" do
      visit "/pages/home/"
      expect(page).to have_selector("title", :text => @base_title+" | Accueil", :visible => false)
    end
  end

  describe "Visit #contact" do
    it "title is MyMoviez | Contact" do
      visit "/pages/contact/"
      expect(page).to have_selector("title", :text => @base_title+" | Contact", :visible => false)
    end
  end

  describe "Visit #about" do
    it "title is MyMoviez | À Propos" do
      visit "/pages/about/"
      expect(page).to have_selector("title", :text => @base_title+" | À Propos", :visible => false)
    end
  end

  describe "Visit #help" do
    it "title is MyMoviez | Aide" do
      visit "/pages/help/"
      expect(page).to have_selector("title", :text => @base_title+" | Aide", :visible => false)
    end
  end

end