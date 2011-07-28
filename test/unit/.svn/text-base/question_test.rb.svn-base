require File.dirname(__FILE__) + "/../test_helper"

class QuestionTest < ActiveSupport::TestCase
  
  def test_should_construct_choice_question_from_content
    question = Question.new(:content => "2+2; [ [\"4\", :right], [\"3\", :wrong], [\"2\", :wrong]]")
    assert question.valid?
  end
  
  def test_should_construct_math_question_from_content
    question = Question.new(:content => "2 + _ = 4")
    assert question.valid?
  end
  
  def test_should_fail_validation_when_content_is_invalid
      question = Question.new(:content => "bfdnfnlnfa")
      assert !question.valid?
  end
  
  def test_should_return_true_for_correct_answer
    question = Question.new(:content => "2+2; [ [\"4\", :right], [\"3\", :wrong], [\"2\", :wrong]]")
    assert question.valid?
    assert !question.correct_answer?("2")
    assert question.correct_answer?("1")
  end
  
end
