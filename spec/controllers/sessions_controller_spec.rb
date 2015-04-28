require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "title is MyMoviez | Connexion" do
      get :new
      expect(response.body).to have_selector("title", :text => "Connexion", :visible => false)
    end
  end


  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end

      it "should render #new page" do
        post :create, :session => @attr
        expect(response).to render_template('new')
      end

      it "Should have good title" do
        post :create, :session => @attr
        expect(response.body).to have_selector("title", :text => "Connexion", :visible => false)
      end

      it "should have message flash.now" do
        post :create, :session => @attr
        expect(flash[:error]).to match /invalid/i
      end

    end

    describe "valid signin" do

      before(:each) do
        @user = create(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should connect user" do
        post :create, :session => @attr
        expect(controller.current_user).to eq(@user)
        expect(controller).to be_signed_in
      end

      it "should redirect to user page" do
        post :create, :session => @attr
        expect(response).to redirect_to(user_path(@user))
      end
    end
  end

  describe "DELETE 'destroy'" do

    it "should disconnect user" do
      test_sign_in(create(:user))
      delete :destroy
      expect(controller).not_to be_signed_in
      expect(controller).to redirect_to(root_path)
    end
  end

end
