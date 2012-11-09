require 'test_helper'

class ChallengeMessagesControllerTest < ActionController::TestCase
  setup do
    @challenge_message = challenge_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenge_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge_message" do
    assert_difference('ChallengeMessage.count') do
      post :create, :challenge_message => { :datetime => @challenge_message.datetime, :location => @challenge_message.location, :receiver_team_id => @challenge_message.receiver_team_id, :sender_team_id => @challenge_message.sender_team_id, :user_id => @challenge_message.user_id }
    end

    assert_redirected_to challenge_message_path(assigns(:challenge_message))
  end

  test "should show challenge_message" do
    get :show, :id => @challenge_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @challenge_message
    assert_response :success
  end

  test "should update challenge_message" do
    put :update, :id => @challenge_message, :challenge_message => { :datetime => @challenge_message.datetime, :location => @challenge_message.location, :receiver_team_id => @challenge_message.receiver_team_id, :sender_team_id => @challenge_message.sender_team_id, :user_id => @challenge_message.user_id }
    assert_redirected_to challenge_message_path(assigns(:challenge_message))
  end

  test "should destroy challenge_message" do
    assert_difference('ChallengeMessage.count', -1) do
      delete :destroy, :id => @challenge_message
    end

    assert_redirected_to challenge_messages_path
  end
end
