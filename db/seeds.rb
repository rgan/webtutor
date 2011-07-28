def should_seed? model
  empty = model.all.empty?
  puts(empty ? "Seeding #{model}." : "Not seeding #{model}. Already populated.")
  empty
end

if should_seed? User 
  # there is one predefined admin user who has the admin role
  admin_user = User.create!(:name => 'admin', :email => 'admin@webtutor.com', :password => 'admin', :password_confirmation => 'admin')
   
  # there are only 3 predefined roles
  tutor_role = Role.create!(:name => 'tutor')
  Role.create!(:name => 'student')
  admin_role = Role.create!(:name => 'admin')
   
  # assign the admin and tutor roles to the admin user
  admin_user.roles << admin_role
  admin_user.roles << tutor_role
end

if should_seed? Topic
  root = Topic.create!(:name =>'ROOT')
  math_topic = Topic.create!(:name => 'Math', :parent => root)
  addition_topic = Topic.create!(:name => 'Addition', :parent => math_topic)
  addition_topic.load_questions('db/migrate/addition_questions.txt')
  Topic.create!(:name => 'Language', :parent => root)
end