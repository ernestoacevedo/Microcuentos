require 'test_helper'

class MicrocuentosControllerTest < ActionController::TestCase
  setup do
    @microcuento = microcuentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microcuentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microcuento" do
    assert_difference('Microcuento.count') do
      post :create, microcuento: { content: @microcuento.content, likes: @microcuento.likes, title: @microcuento.title, user_id: @microcuento.user_id }
    end

    assert_redirected_to microcuento_path(assigns(:microcuento))
  end

  test "should show microcuento" do
    get :show, id: @microcuento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microcuento
    assert_response :success
  end

  test "should update microcuento" do
    put :update, id: @microcuento, microcuento: { content: @microcuento.content, likes: @microcuento.likes, title: @microcuento.title, user_id: @microcuento.user_id }
    assert_redirected_to microcuento_path(assigns(:microcuento))
  end

  test "should destroy microcuento" do
    assert_difference('Microcuento.count', -1) do
      delete :destroy, id: @microcuento
    end

    assert_redirected_to microcuentos_path
  end
end
