require 'test_helper'

class AdvertisementsControllerTest < ActionController::TestCase
  setup do
    @advertisement = advertisements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advertisements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advertisement" do
    assert_difference('Advertisement.count') do
      post :create, advertisement: @advertisement.attributes
    end

    assert_redirected_to advertisement_path(assigns(:advertisement))
  end

  test "should show advertisement" do
    get :show, id: @advertisement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @advertisement.to_param
    assert_response :success
  end

  test "should update advertisement" do
    put :update, id: @advertisement.to_param, advertisement: @advertisement.attributes
    assert_redirected_to advertisement_path(assigns(:advertisement))
  end

  test "should destroy advertisement" do
    assert_difference('Advertisement.count', -1) do
      delete :destroy, id: @advertisement.to_param
    end

    assert_redirected_to advertisements_path
  end
end
