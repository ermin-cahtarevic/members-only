class SessionsController < ApplicationController
    def new
    end  
    
    def create
      user = User.find_by(email: params[:sessions][:email].downcase) 
      if user && user.authenticate(params[:sessions][:password])
        log_in user
        remember user
        redirect_to posts_path
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end  
    end    

    def destroy
      log_out if logged_in?
      redirect_to posts_path
    end
end
