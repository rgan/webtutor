class TopicsController < ApplicationController
  
   layout "main"
   
  before_filter :authorize
  before_filter :authorize_for_tutor, :except => [ :index, :show]  # only a user in tutor role can add/edit topics
  before_filter :load_parent_topic
  
  # GET /topics/:topic_id/topics
  # GET /topics.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/:topic_id/topics/:id   
  # GET /topics/1.xml
  def show
    @topic = @parent.children.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # can define topic only with a parent
  # GET /topics/:topic_id/topics/new   
  # GET /topics/new.xml
  def new
    
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET edit_topic_topic /topics/:topic_id/topics/:id/edit  
  def edit
    @topic = @parent.children.find(params[:id])
  end

  # POST /topics/:topic_id/topics
  def create
    
    @topic = @parent.children.build(params[:topic])

    respond_to do |format|
      if @topic.save
        flash[:notice] = 'Topic was successfully created.'
        format.html { redirect_to(root_path) }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/:topic_id/topics
  def update
   
    @topic = @parent.children.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(root_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/topics
  def destroy
    
    @topic = @parent.children.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end
 
  private
  
    def load_parent_topic
     @parent = Topic.find(params[:topic_id])
    end
    
end
