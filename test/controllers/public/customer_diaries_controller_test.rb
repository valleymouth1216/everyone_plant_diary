require "test_helper"

class Public::CustomerDiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_customer_diaries_index_url
    assert_response :success
  end

  test "should get show" do
    get public_customer_diaries_show_url
    assert_response :success
  end
end
