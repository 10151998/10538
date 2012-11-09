require 'test_helper'

class PractisesControllerTest < ActionController::TestCase
  setup do
    @practise = practises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:practises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create practise" do
    assert_difference('Practise.count') do
      post :create, :practise => {  }
    end

    assert_redirected_to practise_path(assigns(:practise))
  end

  test "should show practise" do
    get :show, :id => @practise
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @practise
    assert_response :success
  end

  test "should update practise" do
    put :update, :id => @practise, :practise => {  }
    assert_redirected_to practise_path(assigns(:practise))
  end

  test "should destroy practise" do
    assert_difference('Practise.count', -1) do
      delete :destroy, :id => @practise
    end

    assert_redirected_to practises_path
  end
end
