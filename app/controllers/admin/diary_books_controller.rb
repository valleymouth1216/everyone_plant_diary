class Admin::DiaryBooksController < ApplicationController
    before_action :authenticate_admin!

  def index
    @customer=Customer.find(params[:customer_id])
    @diary_books =@customer.diary_books
  end

  def show
    @diary_book =DiaryBook.find(params[:id])
  end

  def update
    @diary_book = DiaryBook.find(params[:id])
      if @diary_book.update(diary_book_params)
      flash[:notice] = "日記帳を更新しました。"
      redirect_to admin_diary_book_path(@diary_book)
      else
      render :edit
      end
  end

  private
    def diary_book_params
      params.require(:diary_book).permit(:title,:status,:status_admin, tag_ids: [])
    end
end
