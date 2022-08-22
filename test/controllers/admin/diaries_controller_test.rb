require "test_helper"

class Admin::DiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_diaries_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_diaries_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_diaries_edit_url
    assert_response :success
  end
end
