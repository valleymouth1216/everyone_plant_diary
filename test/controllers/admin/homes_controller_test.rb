require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admin_homes_top_url
    assert_response :success
  end

  test "should get filter_by_date" do
    get admin_homes_filter_by_date_url
    assert_response :success
  end
end
