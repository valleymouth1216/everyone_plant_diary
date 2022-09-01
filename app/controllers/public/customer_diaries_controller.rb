class Public::CustomerDiariesController < ApplicationController
  before_action :authenticate_customer!


  def index
  @customer=Customer.find(params[:customer_id])
  @diary_books=@customer.diary_books.where(status_admin: false,status: true)
  #     # binding.pry
    if params[:diary_book].present?
     @customer =Customer.find(params[:customer_id])
     @diary_book =@customer.diary_books.find(params[:diary_book])
     @diaries= @diary_book.diaries.where(status_admin: false,status: true)
     redirect_to calendar_diaries_path , notice: "この日記帳は非公開のため表示出来ません。" unless @diary_book.status_admin == false && @diary_book.status == true
    end
  end

  def show
    @customer =Customer.find(params[:customer_id])
    @diary= Diary.find(params[:id])
    redirect_to(customers_path) unless @customer.id == @diary.diary_book.customer.id
    redirect_to calendar_diaries_path  , notice: "この日記帳の日付の内容は非公開のため表示出来ません。" unless @diary.status_admin == false && @diary.status == true
  end

  #private

  #def correct_user
   # @customer =Customer.find(params[:customer_id])
   # @diary= Diary.find(params[:id])
   # redirect_to(customers_path) unless @customer.id == @diary.diary_book.customer.id
  #end
  #end

end
