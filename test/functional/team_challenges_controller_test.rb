require 'test_helper'

class TeamChallengesControllerTest < ActionController::TestCase
  setup do
    @team_challenge = team_challenges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_challenges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_challenge" do
    assert_difference('TeamChallenge.count') do
      post :create, :team_challenge => { :datetime => @team_challenge.datetime, :location => @team_challenge.location, :receiver_team_id => @team_challenge.receiver_team_id, :sender_team_id => @team_challenge.sender_team_id }
    end

    assert_redirected_to team_challenge_path(assigns(:team_challenge))
  end

  test "should show team_challenge" do
    get :show, :id => @team_challenge
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_challenge
    assert_response :success
  end

  test "should update team_challenge" do
    put :update, :id => @team_challenge, :team_challenge => { :datetime => @team_challenge.datetime, :location => @team_challenge.location, :receiver_team_id => @team_challenge.receiver_team_id, :sender_team_id => @team_challenge.sender_team_id }
    assert_redirected_to team_challenge_path(assigns(:team_challenge))
  end

  test "should destroy team_challenge" do
    assert_difference('TeamChallenge.count', -1) do
      delete :destroy, :id => @team_challenge
    end

    assert_redirected_to team_challenges_path
  end
end
