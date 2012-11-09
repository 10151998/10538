require 'test_helper'

class SportLevelsControllerTest < ActionController::TestCase
  setup do
    @sport_level = sport_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_level" do
    assert_difference('SportLevel.count') do
      post :create, :sport_level => { :name => @sport_level.name, :sport_id => @sport_level.sport_id }
    end

    assert_redirected_to sport_level_path(assigns(:sport_level))
  end

  test "should show sport_level" do
    get :show, :id => @sport_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sport_level
    assert_response :success
  end

  test "should update sport_level" do
    put :update, :id => @sport_level, :sport_level => { :name => @sport_level.name, :sport_id => @sport_level.sport_id }
    assert_redirected_to sport_level_path(assigns(:sport_level))
  end

  test "should destroy sport_level" do
    assert_difference('SportLevel.count', -1) do
      delete :destroy, :id => @sport_level
    end

    assert_redirected_to sport_levels_path
  end
end
