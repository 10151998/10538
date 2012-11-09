require 'test_helper'

class SchoolTeachersControllerTest < ActionController::TestCase
  setup do
    @school_teacher = school_teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_teacher" do
    assert_difference('SchoolTeacher.count') do
      post :create, :school_teacher => { :school_id => @school_teacher.school_id, :teacher_id => @school_teacher.teacher_id }
    end

    assert_redirected_to school_teacher_path(assigns(:school_teacher))
  end

  test "should show school_teacher" do
    get :show, :id => @school_teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @school_teacher
    assert_response :success
  end

  test "should update school_teacher" do
    put :update, :id => @school_teacher, :school_teacher => { :school_id => @school_teacher.school_id, :teacher_id => @school_teacher.teacher_id }
    assert_redirected_to school_teacher_path(assigns(:school_teacher))
  end

  test "should destroy school_teacher" do
    assert_difference('SchoolTeacher.count', -1) do
      delete :destroy, :id => @school_teacher
    end

    assert_redirected_to school_teachers_path
  end
end
