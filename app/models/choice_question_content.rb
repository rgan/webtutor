require 'action_view/helpers/form_tag_helper'
require 'action_view/helpers/sanitize_helper'

class ChoiceQuestionContent < QuestionContent
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::SanitizeHelper
  extend ActionView::Helpers::SanitizeHelper::ClassMethods
   
  attr_accessor :answers
  
  #2+2; [ ["4", :right], ["3", :wrong], ["2", :wrong]]
  #
  def self.parse(description)
    parts = description.split(";")
    q_content = ChoiceQuestionContent.new
    q_content.description = parts[0]
    q_content.answers = []
    answer_id = 1
    eval(parts[1]).each { | item | 
      q_content.answers<<Answer.new(answer_id, item[1] == :right ? true : false, item[0].to_s) 
      answer_id = answer_id + 1}
    q_content
  end
  
  def correct_answer(answer_id)
    result = answers.select { |answer| answer.id.to_s == answer_id }
    return result.empty? ? false : result.first.right
  end
  
  def render(answer_id, correct)
     html = sanitize(description) + tag("br")
     for answer in answers
       selected = false
       result = ''
       if answer.id.to_s == answer_id
         selected = true
         result = right_or_wrong(correct)
       end
       # <input id="_q3_1" name="_q3" type="radio" value="1" /> 4<br>
       html += radio_button_tag(QuestionsController::PREFIX + id.to_s, answer.id, selected) + sanitize(answer.description) + '&nbsp;' + result + tag("br") 
     end
     html
   end
   
end