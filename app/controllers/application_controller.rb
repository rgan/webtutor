# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '99b22243322d50f32003269f67a6988e'
  
  protected
  
  ROOT = 1
  
  def root_path
       topic_topics_path(ROOT)
  end
  
  def authorize
    @user = User.find_by_id(session[:user_id])
    unless @user
      redirect_to new_session_url
    end
  end
  
  def authorize_for_tutor
    if !(@user && @user.is_tutor)
      redirect_to root_path
    end
  end
  
  def authorize_for_admin
     @user = User.find_by_id(session[:user_id])
     if !(@user && @user.is_admin)
       redirect_to root_path
     end
   end
   
end
