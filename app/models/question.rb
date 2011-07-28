class Question < ActiveRecord::Base
  
  belongs_to :topic, :class_name => "Topic", :foreign_key => "topic_id"
  validates_presence_of :content
  
  attr_accessor :answer_selected
  
  def validate
     begin
       QuestionContent.create(content, id)
     rescue Exception => e
       errors.add_to_base("Invalid syntax for question.") 
     end
  end
  
  def render()
    QuestionContent.create(content, id).render(nil, nil)
  end
  
  def render_with_answer(answer, correct)
    QuestionContent.create(content, id).render(answer, correct)    
  end  
  
  def correct_answer?(answer)
    QuestionContent.create(content, id).correct_answer(answer)
  end
 end
