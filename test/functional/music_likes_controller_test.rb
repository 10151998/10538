require 'test_helper'

class MusicLikesControllerTest < ActionController::TestCase
  setup do
    @music_like = music_likes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_likes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_like" do
    assert_difference('MusicLike.count') do
      post :create, :music_like => { :music_id => @music_like.music_id, :user_id => @music_like.user_id }
    end

    assert_redirected_to music_like_path(assigns(:music_like))
  end

  test "should show music_like" do
    get :show, :id => @music_like
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @music_like
    assert_response :success
  end

  test "should update music_like" do
    put :update, :id => @music_like, :music_like => { :music_id => @music_like.music_id, :user_id => @music_like.user_id }
    assert_redirected_to music_like_path(assigns(:music_like))
  end

  test "should destroy music_like" do
    assert_difference('MusicLike.count', -1) do
      delete :destroy, :id => @music_like
    end

    assert_redirected_to music_likes_path
  end
end
