require 'test_helper'

class TeacherPeclassesControllerTest < ActionController::TestCase
  setup do
    @teacher_peclass = teacher_peclasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_peclasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_peclass" do
    assert_difference('TeacherPeclass.count') do
      post :create, :teacher_peclass => { :peclass_id => @teacher_peclass.peclass_id, :teacher_id => @teacher_peclass.teacher_id }
    end

    assert_redirected_to teacher_peclass_path(assigns(:teacher_peclass))
  end

  test "should show teacher_peclass" do
    get :show, :id => @teacher_peclass
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @teacher_peclass
    assert_response :success
  end

  test "should update teacher_peclass" do
    put :update, :id => @teacher_peclass, :teacher_peclass => { :peclass_id => @teacher_peclass.peclass_id, :teacher_id => @teacher_peclass.teacher_id }
    assert_redirected_to teacher_peclass_path(assigns(:teacher_peclass))
  end

  test "should destroy teacher_peclass" do
    assert_difference('TeacherPeclass.count', -1) do
      delete :destroy, :id => @teacher_peclass
    end

    assert_redirected_to teacher_peclasses_path
  end
end
