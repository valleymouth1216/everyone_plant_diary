class Public::CustomerDiariesController < ApplicationController



  def index
  @customer=Customer.find(params[:customer_id])
  @diary_books=@customer.diary_books
  #     # binding.pry
    if params[:diary_book].present?
     @customer =Customer.find(params[:customer_id])
     @diary_book =@customer.diary_books.find(params[:diary_book])
     @diaries= @diary_book.diaries
    end
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @diary= Diary.find(params[:id])
  end


end
