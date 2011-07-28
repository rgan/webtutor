require 'digest/sha1'

class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => "roles_users"
  has_many :results
  
  attr_accessor :password_confirmation
                  
  validates_presence_of     :name, :email
  validates_uniqueness_of   :email
  validates_format_of       :email, :with => /(\S+)@(\S+)/, :allow_nil => true
  validates_confirmation_of :password
  validates_length_of       :password, :minimum => 4
    
  # 'password' is a virtual attribute,
  # it's not stored in the database.    
  def password
    @password
  end

  # Assigns a new password.
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.encrypted_password = User.encrypt_password(self.password, self.salt)
  end
                
  def validate
     errors.add_to_base("Missing password") if encrypted_password.blank?
  end
                 
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    (user && user.authenticated?(password)) ? user : nil    
  end

  def authenticated?(password)
    self.encrypted_password == User.encrypt_password(password, self.salt)
  end
  
  def is_admin
    has_role(Role::ADMIN)
  end
  
  def is_tutor
   has_role(Role::TUTOR)
  end
  
  def is_student
    has_role(Role::STUDENT)
  end
  
  private
  
  GARBAGE = "foo"
  
  def has_role(name)
    admin_roles = roles.find(:all, :conditions => "name = '#{name}'")
    admin_roles.size > 0
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypt_password(password, salt)
    Digest::SHA1.hexdigest(password + GARBAGE + salt)
  end
  
end
