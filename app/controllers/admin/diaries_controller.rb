class Admin::DiariesController < ApplicationController
    before_action :authenticate_admin!

  def index
    @diary_books = DiaryBook.find(params[:diary_book_id])
    @diaries = @diary_books.diaries
  end

  def show
    @diary_book = DiaryBook.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
  end

  def edit
    @diary_book = DiaryBook.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
  end

  def update
    @diary_book = DiaryBook.find(params[:diary_book_id])
    @diary = @diary_book.diaries.find(params[:id])

    if params[:diary][:image_ids]
       params[:diary][:image_ids].each do |image_id|
        image = @diary.diary_images.find(image_id)
        image.purge
       end
    end
    if @diary.update(diary_params)
        flash[:notice] = "日記を更新しました。"
        redirect_to admin_diary_book_diary_path(@diary_book,@diary)
    else
        render :edit
    end
  end

  private

  def diary_params
  params.require(:diary).permit(:date,:weather,:status,:status_admin,:temperature,:body,diary_images:[])
  end

end
