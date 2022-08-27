require "test_helper"

class Public::MyDiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get my_diary" do
    get public_my_diaries_my_diary_url
    assert_response :success
  end
end
