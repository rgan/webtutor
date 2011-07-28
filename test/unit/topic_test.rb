require File.dirname(__FILE__) + "/../test_helper"

class TopicTest < ActiveSupport::TestCase
  
  def setup
     @topic = Topic.create(:name => "Math")
     @question = Question.create(:topic => @topic, :content => "2+2; [ [\"4\", :right], [\"3\", :wrong], [\"2\", :wrong]]")
     @user = User.create!(:name => 'foo', :email => 'foo@webtutor.com', :password => 'foobar', :password_confirmation => 'foobar')
  end
  
  def test_has_children_should_return_false_when_no_children
     assert !@topic.has_children?
     child_topic = Topic.new(:name => "Addition")
     @topic.children << child_topic
     assert @topic.has_children?
  end
  
  def test_has_questions_should_return_false_when_no_questions
      topic = Topic.new(:name => "foo")
      assert !topic.has_questions?
      question = Question.new
      topic.questions << question
      assert @topic.has_questions?
  end
   
   def test_should_compute_score_for_incorrect_result
       incorrect_result = create_result("2", 10)
       assert 0, incorrect_result.score
       assert incorrect_result.user.id == @user.id
       assert incorrect_result.topic.id == @topic.id
       assert incorrect_result.time_taken_seconds == 10
       assert incorrect_result.questions_with_answers.size == 1
       assert_equal @question, incorrect_result.questions_with_answers[0].question
       assert_equal "2", incorrect_result.questions_with_answers[0].answer
       assert !incorrect_result.questions_with_answers[0].correct
   end
   
   def test_should_compute_score_for_correct_result
       # correct answer should have score of 100
       correct_result = create_result("1", 10)
       assert_equal 100, correct_result.score
   end
   
    def test_should_compute_average_score_for_user_without_results
       avg_score = @topic.average_score(@user)
       assert_equal 0, avg_score
    end
   
   def test_should_compute_average_score_for_user_with_results
      # create 2 results for the user
      create_result("2", 10)
      create_result("1", 10)
      avg_score = @topic.average_score(@user)
      assert_equal 50, avg_score
   end
   
   def create_result(answer_id, time_taken)
     question_answer_map = Hash.new
     question_answer_map[@question.id.to_s] = answer_id
     result = @topic.score(question_answer_map, time_taken, @user)
   end
   
   def test_should_load_questions_from_file
     test_topic = Topic.create(:name => "Test")
     begin
       f = File.new("testfile", "w")
       f.puts("2+2; [ [\"4\", :right], [\"3\", :wrong], [\"2\", :wrong]]")
       f.puts("What is the sum of all the angles in a triangle? ; [[180, :right], [90, :wrong], [360, :wrong]]")
       f.puts("2+_=4")
       f.close
       test_topic.load_questions("testfile")
     ensure
       File.delete("testfile")
     end
     assert_equal 3, test_topic.questions.size
   end
   
end
