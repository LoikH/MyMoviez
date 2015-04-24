class UsersController < ApplicationController
  def new
    @user = User.new
    @title = 'Inscription'
  end

  def create
    @user = User.new(user_params)
    if @user.save
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


  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
    end
end
