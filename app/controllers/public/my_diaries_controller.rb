class Public::MyDiariesController < ApplicationController
  def my_diary
    #@diaries =current_customer.diaries.all
    @diary_books=current_customer.diary_books
       # binding.pry
    if params[:diary_book].present?
      @diary_book =current_customer.diary_books.find(params[:diary_book])
      @diaries= @diary_book.diaries
      #@diaries_count =Item.all
    end

  end
end
