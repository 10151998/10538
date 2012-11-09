require 'test_helper'

class UsersportsPreferencesControllerTest < ActionController::TestCase
  setup do
    @usersports_preference = usersports_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usersports_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usersports_preference" do
    assert_difference('UsersportsPreference.count') do
      post :create, :usersports_preference => { :idsports => @usersports_preference.idsports, :idusers => @usersports_preference.idusers }
    end

    assert_redirected_to usersports_preference_path(assigns(:usersports_preference))
  end

  test "should show usersports_preference" do
    get :show, :id => @usersports_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @usersports_preference
    assert_response :success
  end

  test "should update usersports_preference" do
    put :update, :id => @usersports_preference, :usersports_preference => { :idsports => @usersports_preference.idsports, :idusers => @usersports_preference.idusers }
    assert_redirected_to usersports_preference_path(assigns(:usersports_preference))
  end

  test "should destroy usersports_preference" do
    assert_difference('UsersportsPreference.count', -1) do
      delete :destroy, :id => @usersports_preference
    end

    assert_redirected_to usersports_preferences_path
  end
end
