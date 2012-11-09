require 'test_helper'

class SchoolPeclassesControllerTest < ActionController::TestCase
  setup do
    @school_peclass = school_peclasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_peclasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_peclass" do
    assert_difference('SchoolPeclass.count') do
      post :create, :school_peclass => { :peclass_id => @school_peclass.peclass_id, :school_id => @school_peclass.school_id }
    end

    assert_redirected_to school_peclass_path(assigns(:school_peclass))
  end

  test "should show school_peclass" do
    get :show, :id => @school_peclass
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @school_peclass
    assert_response :success
  end

  test "should update school_peclass" do
    put :update, :id => @school_peclass, :school_peclass => { :peclass_id => @school_peclass.peclass_id, :school_id => @school_peclass.school_id }
    assert_redirected_to school_peclass_path(assigns(:school_peclass))
  end

  test "should destroy school_peclass" do
    assert_difference('SchoolPeclass.count', -1) do
      delete :destroy, :id => @school_peclass
    end

    assert_redirected_to school_peclasses_path
  end
end
