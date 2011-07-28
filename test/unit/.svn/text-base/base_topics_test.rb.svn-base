require File.dirname(__FILE__) + "/../test_helper"

class BaseTopicsTest < ActionController::TestCase
  
  def root_path
     topic_topics_path(1)
  end
  
  def setup_user_and_topic
    setup_user
    setup_topic
  end
  
  def setup_user
     @tutor = User.new
     @tutor.id = 1
     @mock_tutor = flexmock(@tutor)
     flexmock(User).should_receive(:find_by_id).once.with(@tutor.id).and_return( @mock_tutor)
  end
  
  def setup_tutor_and_topic
    setup_user
    @mock_tutor.should_receive(:is_tutor).at_least.once.and_return(true)
    setup_topic
  end
  
  def setup_topic
      @topic = Topic.new(:name => 'Math')
      @topic.id = 1
      @mock_topic = flexmock(@topic)
      flexmock(Topic).should_receive(:find).once.with(@topic.id.to_s).and_return( @mock_topic)

      @question = Question.new(:topic => @topic, :content => "2+2; [ [\"4\", :right], [\"3\", :wrong], [\"2\", :wrong]]")
      @question.id = 1
      @mock_question = flexmock(@question)
      
      @topic_questions_assoc_proxy_mock = flexmock("topic_questions_assoc_proxy_mock")
      @topic_children_assoc_proxy_mock = flexmock("topic_children_assoc_proxy_mock")
  end
end