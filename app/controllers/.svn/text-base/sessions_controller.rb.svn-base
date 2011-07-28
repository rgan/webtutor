class SessionsController < ApplicationController

 layout "main"
 
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to root_path
    else
      flash[:error] = "Invalid email/password combination!"
      redirect_to new_session_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out."
    redirect_to root_path
  end

end
