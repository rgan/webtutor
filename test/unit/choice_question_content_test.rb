require File.dirname(__FILE__) + "/../test_helper"
require 'question_content'

class ChoiceQuestionContentTest < Test::Unit::TestCase
  
  def test_should_parse_question_content
    q = ChoiceQuestionContent.parse("2+2; [ [\"4\", :right], [\"3\", :wrong]] ")
    assert_equal("2+2", q.description)
    assert_equal(2, q.answers.size)
    answer0 = q.answers[0]
    assert_equal(1, answer0.id)
    assert_equal("4", answer0.description)
    assert answer0.right
    answer1 = q.answers[1]
    assert_equal(2, answer1.id)
    assert_equal("3", answer1.description)
    assert !answer1.right
  end
  
  def test_should_return_true_for_correct_answer
    q =  ChoiceQuestionContent.parse("2+2; [ [\"4\", :right], [\"3\", :wrong]] ")
    assert q.correct_answer("1")
  end
  
  def test_should_return_false_for_invalid_answer
     q =  ChoiceQuestionContent.parse("2+2; [ [\"4\", :right], [\"3\", :wrong]] ")
     assert !q.correct_answer("200")
  end
  
  def test_should_render_correctly
    html='2+2<br /><input id="_q_1" name="_q" type="radio" value="1" />4&nbsp;<br />'
    q =  ChoiceQuestionContent.parse("2+2; [ [\"4\", :right]] ")
    assert_equal html, q.render(nil, nil)
  end
  
  def test_should_render_with_correct_answer
    html='2+2<br /><input checked="checked" id="_q_1" name="_q" type="radio" value="1" />4&nbsp;<font color="green">correct</font><br />'
    q =  ChoiceQuestionContent.parse("2+2; [ [\"4\", :right]] ")
    assert_equal html, q.render("1", true)
  end
  
  def test_should_render_with_wrong_answer
    html='2+2<br /><input checked="checked" id="_q_1" name="_q" type="radio" value="1" />3&nbsp;<font color="red">wrong</font><br />'
    q =  ChoiceQuestionContent.parse("2+2; [[\"3\", :wrong]] ")
    assert_equal html, q.render("1", false)
  end
end