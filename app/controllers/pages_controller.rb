class PagesController < ApplicationController
  def home
    @title = "Accueil"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "À Propos"
  end
end
