require 'test_helper'

class FunEventsControllerTest < ActionController::TestCase
  setup do
    @fun_event = fun_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fun_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fun_event" do
    assert_difference('FunEvent.count') do
      post :create, :fun_event => { :datetime => @fun_event.datetime, :location => @fun_event.location, :name => @fun_event.name, :sport_id => @fun_event.sport_id }
    end

    assert_redirected_to fun_event_path(assigns(:fun_event))
  end

  test "should show fun_event" do
    get :show, :id => @fun_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fun_event
    assert_response :success
  end

  test "should update fun_event" do
    put :update, :id => @fun_event, :fun_event => { :datetime => @fun_event.datetime, :location => @fun_event.location, :name => @fun_event.name, :sport_id => @fun_event.sport_id }
    assert_redirected_to fun_event_path(assigns(:fun_event))
  end

  test "should destroy fun_event" do
    assert_difference('FunEvent.count', -1) do
      delete :destroy, :id => @fun_event
    end

    assert_redirected_to fun_events_path
  end
end
