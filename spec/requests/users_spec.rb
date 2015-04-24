require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe "registration" do

    describe "fail" do

      it "should not create user" do
        expect(lambda do
          visit signup_path
          fill_in "Nom d'utilisateur", :with => ""
          fill_in "Email", :with => ""
          fill_in "Mot de passe", :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Inscription"
          expect(page).to render_template('users/new')
          expect(page).to have_selector("div#error_explanation")
        end).not_to change(User, :count)
      end
    end

    describe "success" do

      it "should create user" do
        expect(lambda do
          visit signup_path
          fill_in "Nom d'utilisateur", :with => "John Marston"
          fill_in "Email", :with => "jm@rdr.com"
          fill_in "Mot de passe", :with => "redisdead"
          fill_in "Confirmation", :with => "redisdead"
          click_button "Inscription"
          expect(page).to have_selector("div.flash.success",
                                        :text => "Bienvenue")
          expect(page).to render_template('users/show')
        end).to change(User, :count).by(1)
      end
    end
  end

end
