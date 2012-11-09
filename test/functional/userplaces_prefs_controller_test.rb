require 'test_helper'

class UserplacesPrefsControllerTest < ActionController::TestCase
  setup do
    @userplaces_pref = userplaces_prefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userplaces_prefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userplaces_pref" do
    assert_difference('UserplacesPref.count') do
      post :create, :userplaces_pref => { :idplaces => @userplaces_pref.idplaces, :idusers => @userplaces_pref.idusers }
    end

    assert_redirected_to userplaces_pref_path(assigns(:userplaces_pref))
  end

  test "should show userplaces_pref" do
    get :show, :id => @userplaces_pref
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @userplaces_pref
    assert_response :success
  end

  test "should update userplaces_pref" do
    put :update, :id => @userplaces_pref, :userplaces_pref => { :idplaces => @userplaces_pref.idplaces, :idusers => @userplaces_pref.idusers }
    assert_redirected_to userplaces_pref_path(assigns(:userplaces_pref))
  end

  test "should destroy userplaces_pref" do
    assert_difference('UserplacesPref.count', -1) do
      delete :destroy, :id => @userplaces_pref
    end

    assert_redirected_to userplaces_prefs_path
  end
end
