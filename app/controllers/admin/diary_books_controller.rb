class Admin::DiaryBooksController < ApplicationController
  def index
    @customer=Customer.find(params[:customer_id])
    @diary_books =@customer.diary_books
  end

  def show
    @customer=Customer.find(params[:customer_id])
    @diary_book =@customer.diary_books.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:customer_id])
    @diary_book =@customer.diary_books.find(params[:id])
  end
end
