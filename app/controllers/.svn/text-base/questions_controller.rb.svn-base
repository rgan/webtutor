class QuestionsController < ApplicationController
  
   layout "main"
   
  PREFIX = "_q"
  
  before_filter :authorize
  before_filter :authorize_for_tutor, :except => [ :index, :answers]  # only a user in tutor role can add/edit/delete questions
  before_filter :load_topic
  
  # GET /topics/:topic_id/questions
  def index
    @questions = @topic.questions
    session[:start_time] = Time.now
  end

  # GET /topics/:topic_id/questions/1
  def show
    @question = @topic.questions.find(params[:id])
  end

  # new_topic_question GET /topics/:topic_id/questions/new 
  def new
    @question = Question.new
  end

  # edit_topic_question GET    /topics/:topic_id/questions/:id/edit
  def edit
    @question = @topic.questions.find(params[:id])
  end

  # POST /topics/:topic_id/questions    
  def create
    @question = @topic.questions.build(params[:question])

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(root_path) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/:topic_id/questions/:id 
  def update
    @question = @topic.questions.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(topic_questions_path(@topic))  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/questions/:id  
  # DELETE /questions/1.xml
  def destroy
    @question = @topic.questions.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(topic_questions_path(@topic)) }
      format.xml  { head :ok }
    end
  end
  
  # /topics/:topic_id/questions/answers  
   def answers
     question_answer_map = to_question_answer_map(params)
     if question_answer_map.size > 0 
       @result = @topic.score(question_answer_map, Time.now.to_i - session[:start_time].to_i, @user)
     else
       redirect_to topic_questions_path(@topic.id)
     end
   end
   
   def to_question_answer_map(params_map)
     question_answer_map = Hash.new
     params_map.each { |key, value| 
        key_copy = key.to_s.dup
       if key_copy.sub!(PREFIX, "")
         question_answer_map[key_copy] = value
       end
     }
     question_answer_map
   end
   
  private
  
    def load_topic
      @topic = Topic.find(params[:topic_id])
    end
    
end
