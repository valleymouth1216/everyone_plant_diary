# frozen_string_literal: true

require "test_helper"

class Public::DiaryDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_diary_dates_new_url
    assert_response :success
  end

  test "should get index" do
    get public_diary_dates_index_url
    assert_response :success
  end

  test "should get show" do
    get public_diary_dates_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_diary_dates_edit_url
    assert_response :success
  end
end
