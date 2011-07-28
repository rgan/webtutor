require File.dirname(__FILE__) + "/../test_helper"

class UsersControllerTest < ActionController::TestCase
  
  def setup
     @admin_user = User.create!(:name => 'foo_admin', :email => 'foo_admin@webtutor.com', :password => 'uvwxyz', :password_confirmation => 'uvwxyz')
     admin_role = Role.create!(:name => Role::ADMIN)
     @admin_user.roles << admin_role
     @student_role = Role.create!(:name => Role::STUDENT)
  end
  
  def test_should_create_new_user_with_student_role
    post :create, { :user => { :name => 'auser', :email => 'auser@webtutor.com', :password => 'uvwxyz', :password_confirmation => 'uvwxyz'} }
    user = User.find_by_email('auser@webtutor.com')
    assert_not_nil user
    assert user.is_student
    assert_equal 'auser', session[:user_name]
    assert_equal user.id, session[:user_id]
  end
  
  def test_should_not_allow_assign_role_if_not_admin
    get :assign_role
    assert_redirected_to topic_topics_path(1)
  end
  
  def test_should_get_assign_role_with_roles_not_already_assigned
     get :assign_role, {}, { :user_id => @admin_user.id }
     assert_response :success
     assert_not_nil assigns(:roles)
  end
  
  def test_should_assign_role_to_user
    assert_equal 1, @admin_user.roles.size()
    post :assign_role, { :user_role => { :role_id => @student_role.id }}, { :user_id => @admin_user.id }
    assert_equal 2, User.find_by_name('foo_admin').roles.size()
  end
end