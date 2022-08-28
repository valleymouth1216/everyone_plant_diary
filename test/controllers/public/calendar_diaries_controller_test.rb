require "test_helper"

class Public::CalendarDiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_calendar_diaries_index_url
    assert_response :success
  end

  test "should get show" do
    get public_calendar_diaries_show_url
    assert_response :success
  end
end
