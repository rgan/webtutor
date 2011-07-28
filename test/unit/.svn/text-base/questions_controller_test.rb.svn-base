require File.dirname(__FILE__) + "/../test_helper"
require File.dirname(__FILE__) + "/base_topics_test"

class QuestionsControllerTest < BaseTopicsTest
  
  def test_should_redirect_index_to_login_without_user
    get :index
    assert_redirected_to new_session_url
  end
  
  def test_should_get_index_with_user
    setup_user_and_topic
    @mock_topic.should_receive(:questions).once.and_return([@mock_question])
    get :index, {:topic_id => @topic.id}, {  :user_id => @tutor.id }
    assert_response :success
    assert_not_nil assigns(:questions)
    assert_not_nil assigns(:user)
    assert_not_nil session[:start_time]
  end

  def test_should_get_new
    setup_tutor_and_topic
    get :new,  {:topic_id => @topic.id}, {  :user_id => @tutor.id }
    assert_response :success
  end

  def test_should_create_question
    setup_tutor_and_topic
    flexmock(Question).should_receive(:new).and_return(@mock_question)
    @mock_question.should_receive(:save).once.and_return(true)
    post :create, {:topic_id => @topic.id, :question => {}}, {  :user_id => @tutor.id }
    assert_redirected_to root_path
  end
  
  def setup_expectations_to_retrieve_question_by_topic
    @mock_topic.should_receive(:questions).once.and_return(@topic_questions_assoc_proxy_mock)
    @topic_questions_assoc_proxy_mock.should_receive(:find).once.with(@question.id.to_s).and_return(@mock_question)
  end

  def test_should_show_question
    setup_tutor_and_topic
    setup_expectations_to_retrieve_question_by_topic
    get :show, {:topic_id => @topic.id, :id => @question.id }, {  :user_id => @tutor.id }
    assert_not_nil assigns(:question)
    assert_response :success
  end

  def test_should_get_edit
    setup_tutor_and_topic
    setup_expectations_to_retrieve_question_by_topic
    get :edit, {:topic_id => @topic.id, :id => @question.id }, {  :user_id => @tutor.id }
    assert_response :success
  end

  def test_should_update_question
    setup_tutor_and_topic
    setup_expectations_to_retrieve_question_by_topic
    question_params = {}
    @mock_question.should_receive(:update_attributes).once.with(question_params).and_return(true)
    put :update, {:topic_id => @topic.id, :id => @question.id, :question => question_params}, {  :user_id => @tutor.id }
    assert_redirected_to topic_questions_path(@topic)
  end

  def test_should_destroy_question
    setup_tutor_and_topic
    setup_expectations_to_retrieve_question_by_topic
    @mock_question.destroy
    delete :destroy, {:topic_id => @topic.id, :id => @question.id }, {  :user_id => @tutor.id }
    assert_redirected_to topic_questions_path(@topic)
  end
  
  def test_should_handle_answers
    setup_user_and_topic
    result = Result.new
    result.score = 0.0
    result.questions_with_answers = []
    mock_result = flexmock(result)
    question_answer_map = @controller.to_question_answer_map({"_q1" => "1" })
    @mock_topic.should_receive(:score).once.with(question_answer_map, any, @mock_tutor).and_return(mock_result)
    post :answers, {:topic_id => @topic.id,  :id => @question.id, "_q1" => "1" }, {  :user_id => @tutor.id, :start_time => Time.now}
    assert_not_nil assigns(:result)
  end
  
  def test_should_redirect_to_questions_if_no_answers_selected
     setup_user_and_topic
     post :answers, {:topic_id => @topic.id,  :id => @question.id }, {  :user_id => @tutor.id, :start_time => Time.now}
     assert_redirected_to topic_questions_path(@topic)
  end
  
  def test_should_construct_question_answer_map_from_params
    params = {"commit"=>"Submit", "authenticity_token"=>"ccc", "action"=>"save", "_q1"=>"1", "_q2"=>"1", "controller"=>"main"}
    question_answer_map = @controller.to_question_answer_map(params)
    assert_equal(2, question_answer_map.size)
    assert_equal("1", question_answer_map["1"])
    assert_equal("1", question_answer_map["2"])
  end
  
end
