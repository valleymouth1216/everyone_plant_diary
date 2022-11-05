# frozen_string_literal: true

require "test_helper"

class Public::CustomerDiaryBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_customer_diary_books_index_url
    assert_response :success
  end

  test "should get show" do
    get public_customer_diary_books_show_url
    assert_response :success
  end
end
