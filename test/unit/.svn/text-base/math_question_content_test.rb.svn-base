require File.dirname(__FILE__) + "/../test_helper"

class MathQuestionContentTest < ActiveSupport::TestCase
  
  def test_should_evaluate_valid_content
    qc = MathQuestionContent.parse("2 + _ = 4")
    assert_equal("2 + _ ", qc.lhs)
    assert_equal(" 4", qc.rhs)
  end
  
  def test_should_throw_error_on_invalid_content
    begin
      qc = MathQuestionContent.parse("invalid")
      fail 'exception expected'
    rescue Exception => e
      puts e.to_s
    end
   end
   
   def test_should_return_true_for_correct_answer
     qc = MathQuestionContent.parse("2 + _ = 4")
     assert qc.correct_answer("2")
     assert !qc.correct_answer("3")
   end
   
   def test_should_return_false_for_empty_answer
     qc = MathQuestionContent.parse("2 + _ = 4")
     assert !qc.correct_answer("")
   end
   
   def test_should_return_false_for_invalid_answer
      qc = MathQuestionContent.parse("2 + _ = 4")
      assert !qc.correct_answer("aa")
  end
    
  def test_should_render_correctly
    qc = MathQuestionContent.parse("2 + _ = 4")
    qc.id = "1"
    expected = '2 + _  =  4&nbsp;&nbsp;<input id="_q1" name="_q1" size="15" type="text" />&nbsp;<br />'
    assert_equal expected, qc.render(nil,nil)
  end
  
  def test_should_render_with_answer_correctly
    qc = MathQuestionContent.parse("2 + _ = 4")
    qc.id = "1"
    expected = '2 + _  =  4&nbsp;&nbsp;<input id="_q1" name="_q1" size="15" type="text" value="2" />&nbsp;<font color="green">correct</font><br />'
    assert_equal expected, qc.render(2,true)
  end
  
  def test_format
    puts Time.now
  end
  
end