require 'test_helper'

class FunsControllerTest < ActionController::TestCase
  setup do
    @fun = funs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fun" do
    assert_difference('Fun.count') do
      post :create, :fun => { :datetime => @fun.datetime, :location => @fun.location, :name => @fun.name, :sport_id => @fun.sport_id }
    end

    assert_redirected_to fun_path(assigns(:fun))
  end

  test "should show fun" do
    get :show, :id => @fun
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fun
    assert_response :success
  end

  test "should update fun" do
    put :update, :id => @fun, :fun => { :datetime => @fun.datetime, :location => @fun.location, :name => @fun.name, :sport_id => @fun.sport_id }
    assert_redirected_to fun_path(assigns(:fun))
  end

  test "should destroy fun" do
    assert_difference('Fun.count', -1) do
      delete :destroy, :id => @fun
    end

    assert_redirected_to funs_path
  end
end
