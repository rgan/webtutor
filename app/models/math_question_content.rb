require 'action_view/helpers/form_tag_helper'
require 'action_view/helpers/sanitize_helper'

class MathQuestionContent < QuestionContent
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::SanitizeHelper
  extend ActionView::Helpers::SanitizeHelper::ClassMethods
  
  attr_accessor :lhs, :rhs
  
  # questions: 2 + _ = 4
  def self.parse(content)
    q_content = MathQuestionContent.new
    sides = content.split('=')
    q_content.lhs = sides[0]
    q_content.rhs = sides[1]
    # substitute any number for _ and both sides of the expression must evaluate to numbers.
    eval(q_content.lhs.sub("_", "1")).to_i
    eval(q_content.rhs.sub("_", "1")).to_i
    q_content
  end
  
  def correct_answer(answer)
    if answer == nil || answer.strip.length ==0
      return false
    end
    begin
       return eval(lhs.sub("_", answer)).to_f == eval(rhs.sub("_", answer)).to_f
    rescue
      return false
    end
  end
   
  def render(answer, correct)
    result = ''
    if (answer) 
       result = right_or_wrong(correct)
    end
    html = sanitize(lhs + " = " + rhs) + "&nbsp;&nbsp;" + text_field_tag(QuestionsController::PREFIX + id.to_s, answer, :size => 15) + '&nbsp;' + result + tag("br")
  end
  
end
  
  