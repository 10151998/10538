require 'test_helper'

class UserplacesPreferencesControllerTest < ActionController::TestCase
  setup do
    @userplaces_preference = userplaces_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userplaces_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userplaces_preference" do
    assert_difference('UserplacesPreference.count') do
      post :create, :userplaces_preference => { :idplaces => @userplaces_preference.idplaces, :idusers => @userplaces_preference.idusers }
    end

    assert_redirected_to userplaces_preference_path(assigns(:userplaces_preference))
  end

  test "should show userplaces_preference" do
    get :show, :id => @userplaces_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @userplaces_preference
    assert_response :success
  end

  test "should update userplaces_preference" do
    put :update, :id => @userplaces_preference, :userplaces_preference => { :idplaces => @userplaces_preference.idplaces, :idusers => @userplaces_preference.idusers }
    assert_redirected_to userplaces_preference_path(assigns(:userplaces_preference))
  end

  test "should destroy userplaces_preference" do
    assert_difference('UserplacesPreference.count', -1) do
      delete :destroy, :id => @userplaces_preference
    end

    assert_redirected_to userplaces_preferences_path
  end
end
