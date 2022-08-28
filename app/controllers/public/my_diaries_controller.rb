class Public::MyDiariesController < ApplicationController
  def my_diary

    @diary_books=current_customer.diary_books
    #@diaries= Diary.all
    #@diaries= current_customer.diaries
    #@diary= current_customer.diary
       # binding.pry
    if params[:diary_book].present?
      @diary_book =current_customer.diary_books.find(params[:diary_book])
      @diaries= @diary_book.diaries

    end

  end
end
