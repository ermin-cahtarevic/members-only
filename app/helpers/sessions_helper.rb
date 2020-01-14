module SessionsHelper

  def log_in(user)
    sessions[:user_id] = user.id
  end

  def log_out
    @current_user = nil
    cookies[:remember_token] = nil
    cookies[:user_id] = nil
    sessions[:user_id] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end 
    end
  end

  def current_user=(user)
    @current_user = user
  end

end
