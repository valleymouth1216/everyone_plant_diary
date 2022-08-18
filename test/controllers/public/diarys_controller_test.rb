require "test_helper"

class Public::DiarysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_diarys_new_url
    assert_response :success
  end

  test "should get index" do
    get public_diarys_index_url
    assert_response :success
  end

  test "should get show" do
    get public_diarys_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_diarys_edit_url
    assert_response :success
  end
end
