require 'test_helper'

class UserGamePreferencesControllerTest < ActionController::TestCase
  setup do
    @user_game_preference = user_game_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_game_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_game_preference" do
    assert_difference('UserGamePreference.count') do
      post :create, :user_game_preference => { :game_id => @user_game_preference.game_id, :user_id => @user_game_preference.user_id }
    end

    assert_redirected_to user_game_preference_path(assigns(:user_game_preference))
  end

  test "should show user_game_preference" do
    get :show, :id => @user_game_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_game_preference
    assert_response :success
  end

  test "should update user_game_preference" do
    put :update, :id => @user_game_preference, :user_game_preference => { :game_id => @user_game_preference.game_id, :user_id => @user_game_preference.user_id }
    assert_redirected_to user_game_preference_path(assigns(:user_game_preference))
  end

  test "should destroy user_game_preference" do
    assert_difference('UserGamePreference.count', -1) do
      delete :destroy, :id => @user_game_preference
    end

    assert_redirected_to user_game_preferences_path
  end
end
