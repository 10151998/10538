require 'test_helper'

class MentorMessagesControllerTest < ActionController::TestCase
  setup do
    @mentor_message = mentor_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mentor_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mentor_message" do
    assert_difference('MentorMessage.count') do
      post :create, mentor_message: {  }
    end

    assert_redirected_to mentor_message_path(assigns(:mentor_message))
  end

  test "should show mentor_message" do
    get :show, id: @mentor_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mentor_message
    assert_response :success
  end

  test "should update mentor_message" do
    put :update, id: @mentor_message, mentor_message: {  }
    assert_redirected_to mentor_message_path(assigns(:mentor_message))
  end

  test "should destroy mentor_message" do
    assert_difference('MentorMessage.count', -1) do
      delete :destroy, id: @mentor_message
    end

    assert_redirected_to mentor_messages_path
  end
end
