class Result < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :topic, :foreign_key => "topic_id"
  
  attr_accessor :questions_with_answers
end