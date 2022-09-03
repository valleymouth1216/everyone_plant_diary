class Public::CustomerDiaryBooksController < ApplicationController
  before_action :authenticate_customer!


  def index
    @customer = Customer.find(params[:customer_id])
    @diary_books = @customer.diary_books.where(status_admin: true,status: true)
  #     # binding.pry
    if params[:diary_book].present?
     @customer = Customer.find(params[:customer_id])
     @diary_book = @customer.diary_books.find(params[:diary_book])
     @diary_dates = @diary_book.diary_dates.where(status_admin: true,status: true)
     redirect_to calendar_diaries_path , notice: "この日記帳は非公開のため表示出来ません。" unless @diary_book.status_admin == true && @diary_book.status == true
    end
  end

  def show
    #binding.pry
    @customer =Customer.find(params[:customer_id])
    @diary_date = DiaryDate.find(params[:id])
    @diary_comment = DiaryComment.new
    #binding.pry
    redirect_to(customers_path) if current_customer.id == @diary_date.diary_book.customer.id
    redirect_to calendar_diaries_path , notice: "この日記帳の日付の内容は非公開のため表示出来ません。" unless @diary_date.status_admin == true && @diary_date.status == true
  end

  #private

  #def correct_user
   # @customer =Customer.find(params[:customer_id])
   # @diary= Diary.find(params[:id])
   # redirect_to(customers_path) unless @customer.id == @diary.diary_book.customer.id
  #end
  #end

end
