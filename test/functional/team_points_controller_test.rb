require 'test_helper'

class TeamPointsControllerTest < ActionController::TestCase
  setup do
    @team_point = team_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_point" do
    assert_difference('TeamPoint.count') do
      post :create, :team_point => { :point_of_week => @team_point.point_of_week, :team_id => @team_point.team_id }
    end

    assert_redirected_to team_point_path(assigns(:team_point))
  end

  test "should show team_point" do
    get :show, :id => @team_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_point
    assert_response :success
  end

  test "should update team_point" do
    put :update, :id => @team_point, :team_point => { :point_of_week => @team_point.point_of_week, :team_id => @team_point.team_id }
    assert_redirected_to team_point_path(assigns(:team_point))
  end

  test "should destroy team_point" do
    assert_difference('TeamPoint.count', -1) do
      delete :destroy, :id => @team_point
    end

    assert_redirected_to team_points_path
  end
end
