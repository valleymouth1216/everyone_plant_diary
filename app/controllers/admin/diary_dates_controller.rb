class Admin::DiaryDatesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_diary_book, only: [:show,:index,:update]

  def index
    @diaries = @diary_book.diaries
  end

  def show
    @diary =@diary_book.diaries.find(params[:id])
  end


  def update
    @diary = @diary_book.diaries.find(params[:id])

    if @diary.update(diary_params)
        flash[:notice] = "日記の公開ステータスを更新しました"
        redirect_to admin_diary_book_diary_path(@diary_book,@diary)
    else
        render :edit
    end
  end

  private

  def set_diary_book
    @diary_book = DiaryBook.find(params[:diary_book_id])
  end

  def diary_params
  params.require(:diary).permit(:date,:weather,:status,:status_admin,:temperature,:body,diary_images:[])
  end

end
