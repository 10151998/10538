require 'test_helper'

class PeClassmembersControllerTest < ActionController::TestCase
  setup do
    @pe_classmember = pe_classmembers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pe_classmembers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pe_classmember" do
    assert_difference('PeClassmember.count') do
      post :create, :pe_classmember => { :idpeclasses => @pe_classmember.idpeclasses, :idusers => @pe_classmember.idusers }
    end

    assert_redirected_to pe_classmember_path(assigns(:pe_classmember))
  end

  test "should show pe_classmember" do
    get :show, :id => @pe_classmember
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pe_classmember
    assert_response :success
  end

  test "should update pe_classmember" do
    put :update, :id => @pe_classmember, :pe_classmember => { :idpeclasses => @pe_classmember.idpeclasses, :idusers => @pe_classmember.idusers }
    assert_redirected_to pe_classmember_path(assigns(:pe_classmember))
  end

  test "should destroy pe_classmember" do
    assert_difference('PeClassmember.count', -1) do
      delete :destroy, :id => @pe_classmember
    end

    assert_redirected_to pe_classmembers_path
  end
end
