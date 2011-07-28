class Topic < ActiveRecord::Base
  belongs_to :parent, :class_name => "Topic"
  has_many :children, :class_name => "Topic", :foreign_key => "parent_id", :order => "name", :dependent => :destroy
  has_many :questions, :class_name => "Question", :dependent => :destroy
  has_many :results
 
  validates_presence_of     :name
 
  def has_children?
    children.size > 0    
  end
  
  def has_questions?
    questions.size > 0    
  end
  
  # map: key is question id and value is the id of the answer that the user selected or entered by the user.
  # scores the given set of answers for topic questions and saves a result record
  # TODO: there is a possible race condition here .. questions could be altered.
  def score(question_answer_map, time_taken, user)
    number_of_correct_answers = 0
    questions_with_answer = []
    question_answer_map.keys.each do | q_id|
      qa = QuestionWithAnswer.new
      qa.question = questions.find_by_id(q_id.to_i)
      qa.answer = question_answer_map[q_id]
      if qa.question.correct_answer?(qa.answer)
        qa.correct = true
        number_of_correct_answers = number_of_correct_answers + 1
      end
      questions_with_answer<<qa
    end
    percent = number_of_correct_answers.to_f/questions_with_answer.size
    Result.create(:questions_with_answers=>questions_with_answer,:user => user, :topic => self, :score=> (percent)*100, :time_taken_seconds => time_taken)
  end
  
  # computes average score for the user for this topic based on results of user attempts
  def average_score(user)
    results_for_user = results.find(:all, :conditions => "user_id = #{user.id}")
    results_for_user.size > 0 ? results_for_user.inject(0) {|sum, element| sum + element.score}/results_for_user.size : 0
  end
  
  def load_questions(filename)
    IO.readlines(filename).each do | line|
      question = questions.build(:content => line)
      question.save!()
    end
  end
  
end
