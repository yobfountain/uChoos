require 'test_helper'

class ScenesControllerTest < ActionController::TestCase
  setup do
    @scene = scenes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scenes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scene" do
    assert_difference('Scene.count') do
      post :create, :scene => @scene.attributes
    end

    assert_redirected_to scene_path(assigns(:scene))
  end

  test "should show scene" do
    get :show, :id => @scene.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @scene.to_param
    assert_response :success
  end

  test "should update scene" do
    put :update, :id => @scene.to_param, :scene => @scene.attributes
    assert_redirected_to scene_path(assigns(:scene))
  end

  test "should destroy scene" do
    assert_difference('Scene.count', -1) do
      delete :destroy, :id => @scene.to_param
    end

    assert_redirected_to scenes_path
  end
end
