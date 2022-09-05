class Admin::DiaryDatesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_diary_book, only: [:show,:update]

  def show
    @diary_date = @diary_book.diary_dates.find(params[:id])
  end


  def update
    @diary_date = @diary_book.diary_dates.find(params[:id])

    if @diary_date.update(diary_params)
        flash[:notice] = "日記の公開ステータスを更新しました"
        redirect_to admin_diary_book_diary_date_path(@diary_book,@diary_date)
    else
        render :edit
    end
  end

  private

  def set_diary_book
    @diary_book = DiaryBook.find(params[:diary_book_id])
  end

  def diary_params
  params.require(:diary_date).permit(:date,:weather,:status,:status_admin,:temperature,:body,diary_images:[])
  end

end
