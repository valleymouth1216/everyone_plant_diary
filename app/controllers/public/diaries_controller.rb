class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_diary_book, only: [:new, :create, :show, :edit, :destroy, :update]


  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)

    @diarys = @diary_book.diaries
    #byebug
    # binding.pry
    @diary.diary_book_id = @diary_book.id

    if @diary.save
      flash[:notice] = "日記を作成しました。"
      redirect_to diary_book_diary_path(@diary_book,@diary)
    else
      render :new
    end
  end

  def index
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

  def show
    @diary = @diary_book.diaries.find(params[:id])
  end

  def edit
    @diary = @diary_book.diaries.find(params[:id])
  end

  def destroy
    @diary = @diary_book.diaries.find(params[:id])
    @diary_redirect = @diary_book.diaries.find(params[:id])
    @diary.destroy
    flash[:notice] = "日記を削除しました。"
    redirect_to diary_books_diaries_path(diary_book: @diary_redirect.diary_book.id)
  end

  def update
    @diary = @diary_book.diaries.find(params[:id])
    if params[:diary][:image_ids]
       params[:diary][:image_ids].each do |image_id|
        image = @diary.diary_images.find(image_id)
        image.purge
       end
    end
    if @diary.update(diary_params)
        flash[:notice] = "日記を更新しました。"
        redirect_to  diary_book_diary_path(@diary_book,@diary)
    else
        render :edit
    end
  end


  private


  def set_diary_book
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
  end

  def diary_params
    params.require(:diary).permit(:start_time,:status,:body,:temperature,:weather,diary_images: [])
  end
end

