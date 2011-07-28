class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => "roles_users"
  
  validates_presence_of     :name
  
  ALL_ROLES = self.find(:all, :order => :name)
  
  ADMIN = 'admin'
  TUTOR = 'tutor'
  STUDENT = 'student'
  
end
  