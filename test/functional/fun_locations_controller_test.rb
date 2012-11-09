require 'test_helper'

class FunLocationsControllerTest < ActionController::TestCase
  setup do
    @fun_location = fun_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fun_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fun_location" do
    assert_difference('FunLocation.count') do
      post :create, :fun_location => { :address => @fun_location.address, :gmaps => @fun_location.gmaps, :latitude => @fun_location.latitude, :longitude => @fun_location.longitude, :name => @fun_location.name }
    end

    assert_redirected_to fun_location_path(assigns(:fun_location))
  end

  test "should show fun_location" do
    get :show, :id => @fun_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fun_location
    assert_response :success
  end

  test "should update fun_location" do
    put :update, :id => @fun_location, :fun_location => { :address => @fun_location.address, :gmaps => @fun_location.gmaps, :latitude => @fun_location.latitude, :longitude => @fun_location.longitude, :name => @fun_location.name }
    assert_redirected_to fun_location_path(assigns(:fun_location))
  end

  test "should destroy fun_location" do
    assert_difference('FunLocation.count', -1) do
      delete :destroy, :id => @fun_location
    end

    assert_redirected_to fun_locations_path
  end
end
