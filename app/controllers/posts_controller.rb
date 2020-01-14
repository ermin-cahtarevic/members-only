class PostsController < ApplicationController
  before_action  :logged_in_user, only: [:new, :create]
  
  def new
    
  end  

  private
  def logged_in_user
    unless logged_in?
        flash[:danger] = "please login"
       redirect_to login_path 
    end
  end
end
