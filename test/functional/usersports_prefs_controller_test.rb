require 'test_helper'

class UsersportsPrefsControllerTest < ActionController::TestCase
  setup do
    @usersports_pref = usersports_prefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usersports_prefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usersports_pref" do
    assert_difference('UsersportsPref.count') do
      post :create, :usersports_pref => { :idsports => @usersports_pref.idsports, :idusers => @usersports_pref.idusers }
    end

    assert_redirected_to usersports_pref_path(assigns(:usersports_pref))
  end

  test "should show usersports_pref" do
    get :show, :id => @usersports_pref
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @usersports_pref
    assert_response :success
  end

  test "should update usersports_pref" do
    put :update, :id => @usersports_pref, :usersports_pref => { :idsports => @usersports_pref.idsports, :idusers => @usersports_pref.idusers }
    assert_redirected_to usersports_pref_path(assigns(:usersports_pref))
  end

  test "should destroy usersports_pref" do
    assert_difference('UsersportsPref.count', -1) do
      delete :destroy, :id => @usersports_pref
    end

    assert_redirected_to usersports_prefs_path
  end
end
