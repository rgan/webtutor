class Answer
  attr_reader :id, :right, :description
  
  def initialize(id, right, description)
    @id = id
    @right = right
    @description = description
  end
  
end