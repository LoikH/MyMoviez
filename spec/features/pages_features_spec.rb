require "rails_helper"

RSpec.describe "PagesManagement", type: :feature do

  before(:each) do
    @base_title = "MyMoviez"
  end

  describe "Visit #home" do
    it "title is MyMoviez | Accueil" do
      visit '/'
      expect(page).to have_selector("title", :text => @base_title+" | Accueil", :visible => false)
    end
  end

  describe "Visit #contact" do
    it "title is MyMoviez | Contact" do
      visit '/contact'
      expect(page).to have_selector("title", :text => @base_title+" | Contact", :visible => false)
    end
  end

  describe "Visit #about" do
    it "title is MyMoviez | À Propos" do
      visit '/about'
      expect(page).to have_selector("title", :text => @base_title+" | À Propos", :visible => false)
    end
  end

  describe "Visit #help" do
    it "title is MyMoviez | Aide" do
      visit '/help'
      expect(page).to have_selector("title", :text => @base_title+" | Aide", :visible => false)
    end
  end

  describe "Visit #signup" do
    it "title is MyMoviez | Inscription" do
      visit '/signup'
      expect(page).to have_selector("title", :text => @base_title+" | Inscription", :visible => false)
    end
  end

end