class UsersController < ApplicationController

before_filter :authenticate, :only => [:index, :show, :edit, :update]
before_filter :correct_user, :only => [:edit, :update]

  def index
    @title = "Liste des utilisateurs"
    @users = User.paginate(:page => params[:page])
  end

  def new
    @user = User.new
    @title = 'Inscription'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans MyMoviez!"
      redirect_to @user
    else
      @title = 'Inscription'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.username
  end

  def edit
    @title = "Edition du profil"
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @title = "Edition du profil"
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
    end

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, :notice => "Vous n'avez pas accès à la page souhaitée. Retour à l'accueil.") unless current_user?(@user)
    end
end
