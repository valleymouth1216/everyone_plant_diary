class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =Diary.new
  end

  def create
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary = Diary.new(diary_params)

    @diarys = @diary_book.diaries
    #byebug
    # binding.pry
    @diary.diary_book_id = @diary_book.id

    if @diary.save
      flash[:notice] = "日記を作成しました。"
      redirect_to diary_book_diaries_path(@diary_book)
    else
      render :new
    end
  end


  def index
    @diary_books = current_customer.diary_books.find(params[:diary_book_id])
    #@diary_books = current_customer.diary_books.where(:id => params[:diary_book_id]).first
    @diarys = @diary_books.diaries
    @number= 0

  end

  def show
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
  end

  def edit
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
  end

  def destroy
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
    @diary.destroy
    flash[:notice] = "日記を削除しました。"
    redirect_to diary_book_diaries_path(@diary_book)
  end

  def update
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
      if @diary.update(diary_params)
      flash[:notice] = "日記を更新しました。"
      redirect_to diary_book_diaries_path(@diary_book)
      else
      render :edit
      end
  end

    private
    def diary_params
      params.require(:diary).permit(:start_time,:status,:body,:temperature,:weather,diary_images: [])
    end
end

