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
      expect(response.body).to have_selector("title", "MyMoviez | Inscription", :visible => false)
    end
  end

end
