class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    
    execute "alter table topics add constraint fk_topics_topics
              foreign key (parent_id) references topics(id)"
    
    create_table :questions do |t|
      t.text :content
      t.integer :topic_id

      t.timestamps
    end
    
    execute "alter table questions
              add constraint fk_questions_topics
              foreign key (topic_id)
              references topics(id)"
  
    create_table :users, :force => true do |t|
      t.string   :name
      t.string   :email
      t.string   :encrypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.timestamps
    end
    
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :roles_users, :id => false do |t|
      t.integer :role_id
      t.integer :user_id
      
      t.timestamps
    end
    
    execute "alter table roles_users
                add constraint fk_roles_users_user_id
                foreign key (user_id)
                references users(id)"
                
    execute "alter table roles_users
                            add constraint fk_roles_users_role_id
                            foreign key (role_id)
                            references roles(id)"
       
    create_table :results do |t|
      t.column :user_id, :integer
      t.column :topic_id, :integer
      t.column :score, :float
      t.column :time_taken_seconds, :integer
      t.timestamps
    end
    
    execute "alter table results
                            add constraint fk_results_user_id
                            foreign key (user_id)
                            references users(id)"
                                      
    execute "alter table results
                        add constraint fk_results_topic_id
                        foreign key (topic_id)
                        references topics(id)"
  end

  def self.down
    drop_table :questions
    drop_table :results
    drop_table :topics
    drop_table :roles_users
    drop_table :users
    drop_table :roles
  end
  
end
