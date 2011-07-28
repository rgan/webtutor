require File.dirname(__FILE__) + "/../test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create!(:name => 'test', :email => 'test@webtutor.com', :password => 'test', :password_confirmation => 'test')
  end
  
  def test_should_fail_validation_if_passwords_dont_match
    auser = User.create(:name => 'test1', :email => 'test1@webtutor.com', :password => 'test1', :password_confirmation => 'test2')
    assert !auser.valid?
  end
  
  def test_should_authenticate_with_valid_password
    assert_equal @user, User.authenticate(@user.email, @user.password)
  end
  
  def test_should_not_authenticate_with_invalid_password
    assert_nil User.authenticate(@user.email, 'invalid')
  end
  
  def test_is_admin_should_return_true_if_has_admin_role
    assert !@user.is_admin
    @user.roles.clear
    @role = Role.create!(:name => Role::ADMIN)
    @user.roles<<@role
    assert @user.is_admin
  end
  
  def test_is_tutor_should_return_true_if_has_tutor_role
    assert !@user.is_tutor
     @role = Role.create!(:name => Role::TUTOR)
     @user.roles<<@role
     assert @user.is_tutor
  end
  
  def test_is_tutor_should_return_true_if_has_student_role
    assert !@user.is_student
     @role = Role.create!(:name => Role::STUDENT)
     @user.roles<<@role
     assert @user.is_student
  end
   
end

