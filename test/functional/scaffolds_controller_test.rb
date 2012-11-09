require 'test_helper'

class ScaffoldsControllerTest < ActionController::TestCase
  setup do
    @scaffold = scaffolds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scaffolds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scaffold" do
    assert_difference('Scaffold.count') do
      post :create, :scaffold => { :Sport_level => @scaffold.Sport_level, :name => @scaffold.name, :sport_id => @scaffold.sport_id }
    end

    assert_redirected_to scaffold_path(assigns(:scaffold))
  end

  test "should show scaffold" do
    get :show, :id => @scaffold
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @scaffold
    assert_response :success
  end

  test "should update scaffold" do
    put :update, :id => @scaffold, :scaffold => { :Sport_level => @scaffold.Sport_level, :name => @scaffold.name, :sport_id => @scaffold.sport_id }
    assert_redirected_to scaffold_path(assigns(:scaffold))
  end

  test "should destroy scaffold" do
    assert_difference('Scaffold.count', -1) do
      delete :destroy, :id => @scaffold
    end

    assert_redirected_to scaffolds_path
  end
end
