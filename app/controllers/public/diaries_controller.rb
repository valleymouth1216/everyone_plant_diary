class Public::DiariesController < ApplicationController
  def new
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =Diary.new
  end

  def create
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary = Diary.new(diary_params)
    #byebug
    @diary.diary_book_id = @diary_book.id
    # params[:id]
    #  binding.pry
    if @diary.save
      flash[:notice] = "日記を作成しました。"
      redirect_to diary_book_diaries_path(@diary_book)
    else
      render :new
    end
  end

  def index
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary = Diary.new(diary_params)
  end

  def show
  end

  def edit
  end

    private
    def diary_params
      params.require(:diary).permit(:date,:status,:body,:temperature)
    end
end

