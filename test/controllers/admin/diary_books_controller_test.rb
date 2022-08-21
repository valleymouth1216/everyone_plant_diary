require "test_helper"

class Admin::DiaryBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_diary_books_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_diary_books_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_diary_books_edit_url
    assert_response :success
  end
end
