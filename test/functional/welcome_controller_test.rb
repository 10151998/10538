require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get press" do
    get :press
    assert_response :success
  end

  test "should get investor" do
    get :investor
    assert_response :success
  end

end
