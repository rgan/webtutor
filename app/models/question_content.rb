class QuestionContent
  
  attr_accessor :description, :id
  
  def self.create(content, question_id)
    begin
        qc = MathQuestionContent.parse(content)
    rescue Exception => e
        qc = ChoiceQuestionContent.parse(content)
    end
    qc.id = question_id
    qc
  end
  
  def render()
     render(nil, nil)
  end
  
  def right_or_wrong(correct)
    if (correct)
       return content_tag(:font, "correct", :color => "green")
     else
       return content_tag(:font, "wrong", :color => "red")
     end
  end 
   
  
end
