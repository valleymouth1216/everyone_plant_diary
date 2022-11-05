# frozen_string_literal: true

require "test_helper"

class Admin::DiaryDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_diary_dates_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_diary_dates_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_diary_dates_edit_url
    assert_response :success
  end
end
