class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:success] = "User successfully created."
      log_in @user
      redirect_to posts_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:users).permit(:name, :email, :password, :password_confirmation)
    end
end
