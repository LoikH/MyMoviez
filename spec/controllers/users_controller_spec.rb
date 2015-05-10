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

        describe "Fail" do

          it "should redirect to signin page" do
            get :show, :id => @user
            expect(response).to redirect_to(signin_path)
          end

          it "should have notice flash" do
            get :show, :id => @user
            expect(flash[:notice]).to match /Vous devez vous identifier pour rejoindre cette page/i
          end
        end

        describe "success" do

          before(:each) do
            test_sign_in(@user)
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

  describe "GET 'edit'" do

    before(:each) do
      @user = create(:user)
      test_sign_in(@user)
    end

    it "should success" do
      get :edit, :id => @user
      expect(response).to have_http_status(:success)
    end

    it "should have good title" do
      get :edit, :id => @user
      expect(response.body).to have_selector("title", :text => "Edition du profil", :visible => false)
    end

    it "should have link to gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      expect(response.body).to have_selector("a[href='#{gravatar_url}']")
    end
  end

  describe "PUT 'update'" do

  before(:each) do
      @user = create(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :username => "", :password => "",
                  :password_confirmation => "" }
      end

        it "should has good title" do
          put :update, :id => @user, :user => @attr
          expect(response.body).to have_selector("title", :text => "Edition du profil", :visible => false)
        end

        it "should render 'edit' page" do
          put :update, :id => @user, :user => @attr
          expect(response).to render_template('edit')
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :username => "New Name", :email => "user@example.com",
            :password => "foobar", :password_confirmation => "foobar" }
          end

          it "should update user data" do
            put :update, :id => @user, :user => @attr
            @user.reload
            expect(@user.username).to  eq(@attr[:username])
            expect(@user.email).to eq(@attr[:email])
          end

          it "should redirect to user page" do
            put :update, :id => @user, :user => @attr
            expect(response).to redirect_to(user_path(@user))
          end

          it "should has welcome message" do
            put :update, :id => @user, :user => @attr
            expect(flash[:success]).to match /actualisé/i
          end   

        end
      end

  describe "authentification des pages edit/update" do

    before(:each) do
      @user = create(:user)
    end

    describe "pour un utilisateur non identifié" do

      it "devrait refuser l'acccès à l'action 'edit'" do
        get :edit, :id => @user
        expect(response).to redirect_to(signin_path)
      end

      it "devrait refuser l'accès à l'action 'update'" do
        put :update, :id => @user, :user => {}
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "pour un utilisateur identifié" do

      before(:each) do
        wrong_user = create(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "devrait correspondre à l'utilisateur à éditer" do
        get :edit, :id => @user
        expect(response).to redirect_to(root_path)
      end

      it "devrait correspondre à l'utilisateur à actualiser" do
        put :update, :id => @user, :user => {}
        expect(response).to redirect_to(root_path)
      end
    end

  end


  describe "GET 'index'" do

    describe "pour utilisateur non identifiés" do
      it "devrait refuser l'accès" do
        get :index
        expect(response).to redirect_to(signin_path)
        expect(flash[:notice]).to match /identifier/i
      end
    end

    describe "pour un utilisateur identifié" do

      before(:each) do
        @user = test_sign_in(create(:user))
        second = create(:user, :email => "another@example.com")
        third  = create(:user, :email => "another@example.net")

        @users = [@user, second, third]
      end

      it "devrait réussir" do
        get :index
        expect(response).to be_success
      end

      it "devrait avoir le bon titre" do
        get :index
        expect(response.body).to have_selector("title", :text => "Liste des utilisateurs", :visible => false)
      end

      it "devrait avoir un élément pour chaque utilisateur" do
        get :index
        @users.each do |user|
          expect(response.body).to have_selector("li", :text => user.username)
        end
      end
    end
  end

end
