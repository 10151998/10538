require 'test_helper'

class UserFunsControllerTest < ActionController::TestCase
  setup do
    @user_fun = user_funs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_funs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_fun" do
    assert_difference('UserFun.count') do
      post :create, :user_fun => { :fun_id => @user_fun.fun_id, :user_id => @user_fun.user_id }
    end

    assert_redirected_to user_fun_path(assigns(:user_fun))
  end

  test "should show user_fun" do
    get :show, :id => @user_fun
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_fun
    assert_response :success
  end

  test "should update user_fun" do
    put :update, :id => @user_fun, :user_fun => { :fun_id => @user_fun.fun_id, :user_id => @user_fun.user_id }
    assert_redirected_to user_fun_path(assigns(:user_fun))
  end

  test "should destroy user_fun" do
    assert_difference('UserFun.count', -1) do
      delete :destroy, :id => @user_fun
    end

    assert_redirected_to user_funs_path
  end
end
