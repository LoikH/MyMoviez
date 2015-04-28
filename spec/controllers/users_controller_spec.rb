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
      expect(response.body).to have_selector("title", :text => "Inscription", :visible => false)
    end


  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :username => "", :email => "", :password => "",
          :password_confirmation => "" }
        end

        it "should not create user" do
          expect(lambda do
            post :create, :user => @attr
          end).not_to change(User, :count)
        end

        it "should has good title" do
          post :create, :user => @attr
          expect(response.body).to have_selector("title", :text => "Inscription", :visible => false)
        end

        it "should render 'new' page" do
          post :create, :user => @attr
          expect(response).to render_template('new')
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :username => "New User", :email => "user@example.com",
            :password => "foobar", :password_confirmation => "foobar" }
          end

          it "should create user" do
            expect(lambda do
              post :create, :user => @attr
            end).to change(User, :count).by(1)
          end

          it "should redirect to user page" do
            post :create, :user => @attr
            expect(response).to redirect_to(user_path(assigns(:user)))
          end

          it "should has welcome message" do
            post :create, :user => @attr
            expect(flash[:success]).to match /Bienvenue dans MyMoviez/i
          end   

           it "should connect user" do
            post :create, :user => @attr
            expect(controller).to be_signed_in
          end
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
