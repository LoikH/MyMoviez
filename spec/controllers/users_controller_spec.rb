require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "title is MyMoviez | Inscription" do
      get :new
      expect(response.body).to have_selector("title", :text => "MyMoviez | Inscription", :visible => false)
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = create(:user)
    end

    it "returns http success" do
      get :show, :id => @user
      expect(response).to have_http_status(:success)
    end

    it "should find good user" do
      get :show, :id => @user
      expect(assigns(:user)).to eq(@user)
    end

    it "title contains username" do
      get :show, :id => @user
      expect(response.body).to have_selector("title", :text => @user.username, :visible => false)
    end

    it "h1 contains username" do
      get :show, :id => @user
      expect(response.body).to have_selector("h1", :text => @user.username)
    end

    it "should has gravatar" do
      get :show, :id => @user
      expect(response.body).to have_selector("h1>img[class='gravatar']")
    end
  end

end
