require File.dirname(__FILE__) + "/../test_helper"
require File.dirname(__FILE__) + "/base_topics_test"

class TopicsControllerTest < BaseTopicsTest
  
  def test_should_redirect_index_to_login_without_user
    get :index
    assert_redirected_to new_session_url
  end
  
  def test_should_get_index
    setup_user_and_topic
    get :index, {:topic_id => @topic.id}, {  :user_id => @tutor.id }
    assert_response :success
    assert_not_nil assigns(:parent)
  end

  def test_should_get_new
    setup_tutor_and_topic
    get :new,  {:topic_id => @topic.id}, {  :user_id => @tutor.id }
    assert_response :success
  end
  
  def test_should_create_topic
    setup_tutor_and_topic
    @mock_topic.should_receive(:children).once.and_return(@topic_children_assoc_proxy_mock)
    topic_params = {}
    mock_child_topic = flexmock("child topic")
    @topic_children_assoc_proxy_mock.should_receive(:build).once.with(topic_params).and_return(mock_child_topic)
    mock_child_topic.should_receive(:save).once.and_return(true)
    post :create, {:topic_id => @topic.id, :topic => topic_params}, {  :user_id => @tutor.id }
    assert_redirected_to root_path
  end

  def setup_expectations_to_retrieve_child_topic
    @child_topic = Topic.new
    @child_topic.id = 3
    @mock_child_topic = flexmock(@child_topic)
    @mock_topic.should_receive(:children).once.and_return(@topic_children_assoc_proxy_mock)
    @topic_children_assoc_proxy_mock.should_receive(:find).once.with(@child_topic.id.to_s).and_return(@mock_child_topic)
  end
  
  def test_should_show_topic
    setup_user_and_topic
    setup_expectations_to_retrieve_child_topic
    get :show, {:topic_id => @topic.id, :id => @child_topic.id}, {  :user_id => @tutor.id }
    assert_response :success
    assert_not_nil assigns(:parent)
    assert_not_nil assigns(:topic)
  end

  def test_should_get_edit
    setup_tutor_and_topic
    setup_expectations_to_retrieve_child_topic
    get :edit, {:topic_id => @topic.id, :id => @child_topic.id}, {  :user_id => @tutor.id }
    assert_response :success
  end

  def test_should_update_topic
    setup_tutor_and_topic
    setup_expectations_to_retrieve_child_topic
    topic_params = {}
    @mock_child_topic.should_receive(:update_attributes).once.with(topic_params).and_return(true)
    put :update, {:topic_id => @topic.id, :id => @child_topic.id, :topic => topic_params}, {  :user_id => @tutor.id }
    assert_redirected_to root_path
  end

  def test_should_destroy_topic
     setup_tutor_and_topic
     setup_expectations_to_retrieve_child_topic
     @mock_child_topic.destroy
     delete :destroy,  {:topic_id => @topic.id, :id => @child_topic.id}, {  :user_id => @tutor.id }
    assert_redirected_to root_path
  end
  
end
