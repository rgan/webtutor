require File.dirname(__FILE__) + "/../test_helper"

class SessionsControllerTest < ActionController::TestCase
  
  def test_should_create_session_with_valid_login
     @a_user = User.create!(:name => 'auser', :email => 'auser@webtutor.com', :password => 'uvwxyz', :password_confirmation => 'uvwxyz')
     post :create, { :email => @a_user.email, :password => @a_user.password }
     assert_equal @a_user.name, session[:user_name]
     assert_equal @a_user.id, session[:user_id]
     assert_redirected_to topic_topics_path(1)
  end
  
  def test_should_not_create_session_with_invalid_login
     post :create, { :email => "email", :password => "invalid" }
     assert_nil session[:user_id]
     assert_nil session[:user_name]
     assert_redirected_to new_session_url
  end
  
  def test_should_clear_user_from_session_on_destroy
    @a_user = User.create!(:name => 'auser', :email => 'auser@webtutor.com', :password => 'uvwxyz', :password_confirmation => 'uvwxyz')
    post :create, { :email => @a_user.email, :password => @a_user.password }
    assert_equal @a_user.id, session[:user_id]
    post :destroy
    assert_equal nil, session[:user_id]
  end
end
