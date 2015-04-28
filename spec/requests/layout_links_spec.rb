require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do

  before(:each) do
    @base_title = "MyMoviez"
  end

  describe "GET /" do
    it "returns http success" do
      get '/'
      expect(response).to have_http_status(200)
    end

    it "title is MyMoviez | Accueil" do
      get '/'
      expect(response.body).to have_selector("title", :text => @base_title+" | Accueil", :visible => false)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get '/contact'
      expect(response).to have_http_status(200)
    end

    it "title is MyMoviez | Contact" do
      get '/contact'
      expect(response.body).to have_selector("title", :text => @base_title+" | Contact", :visible => false)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get '/about'
      expect(response).to have_http_status(200)
    end

    it "title is MyMoviez | À Propos" do
      get '/about'
      expect(response.body).to have_selector("title", :text => @base_title+" | À Propos", :visible => false)
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get '/help'
      expect(response).to have_http_status(200)
    end

    it "title is MyMoviez | Aide" do
      get '/help'
      expect(response.body).to have_selector("title", :text => @base_title+" | Aide", :visible => false)
    end
  end

  describe "GET /signup" do
    it "returns http success" do
      get '/signup'
      expect(response).to have_http_status(200)
    end

    it "title is MyMoviez | Inscription" do
      get '/signup'
      expect(response.body).to have_selector("title", :text => @base_title+" | Inscription", :visible => false)
    end
  end

  describe "when not connected" do
    it "should have connect link" do
      visit root_path
      expect(page).to have_selector("a[href='#{signin_path}']")
    end

    it "should not have connect link" do
      visit root_path
      expect(page).not_to have_selector("a[href='#{signout_path}']")
    end
  end

  describe "when connected" do

    before(:each) do
      @user = create(:user)
      visit signin_path
      fill_in "Email",    :with => @user.email
      fill_in "Mot de passe", :with => @user.password
      click_button "Se connecter"
    end

    it "should have disconnect link" do
      visit root_path
      expect(page).to have_selector("a[href='#{signout_path}']")
    end

    it "should not have connect link" do
      visit root_path
      expect(page).not_to have_selector("a[href='#{signin_path}']")
    end

    it "should not have register link" do
      visit root_path
      expect(page).not_to have_selector("a[href='#{signup_path}']")
    end

    it "should have profil link" do
      visit root_path
      expect(page).to have_selector("a[href='#{user_path(@user)}']")
    end
  end
end
