require 'rails_helper'

RSpec.describe "FriendlyForwardings", type: :request do
  it "devrait rediriger vers la page voulue après identification" do
    user = create(:user)
    visit edit_user_path(user)
    # Le test suit automatiquement la redirection vers la page d'identification.
    fill_in "Email",    :with => user.email
    fill_in "Mot de passe", :with => user.password
    click_button "Se connecter"
    # Le test suit à nouveau la redirection, cette fois vers users/edit.
    expect(page).to render_template('users/edit')
  end
end
