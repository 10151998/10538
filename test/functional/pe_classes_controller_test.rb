require 'test_helper'

class PeClassesControllerTest < ActionController::TestCase
  setup do
    @pe_class = pe_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pe_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pe_class" do
    assert_difference('PeClass.count') do
      post :create, :pe_class => { :datetime => @pe_class.datetime, :idschools => @pe_class.idschools, :idteachers => @pe_class.idteachers, :name => @pe_class.name }
    end

    assert_redirected_to pe_class_path(assigns(:pe_class))
  end

  test "should show pe_class" do
    get :show, :id => @pe_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pe_class
    assert_response :success
  end

  test "should update pe_class" do
    put :update, :id => @pe_class, :pe_class => { :datetime => @pe_class.datetime, :idschools => @pe_class.idschools, :idteachers => @pe_class.idteachers, :name => @pe_class.name }
    assert_redirected_to pe_class_path(assigns(:pe_class))
  end

  test "should destroy pe_class" do
    assert_difference('PeClass.count', -1) do
      delete :destroy, :id => @pe_class
    end

    assert_redirected_to pe_classes_path
  end
end
