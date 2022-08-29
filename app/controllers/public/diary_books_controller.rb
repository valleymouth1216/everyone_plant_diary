class Public::DiaryBooksController < ApplicationController
  before_action :authenticate_customer!

  def new
    @diary_book=DiaryBook.new
  end

  def create
    @diary_book = DiaryBook.new(diary_book_params)
    @diary_books = current_customer.diary_books
    #byebug
    #binding.pry
    @diary_book.customer_id = current_customer.id
    if @diary_book.save
      flash[:notice] = "日記帳を作成しました。"
      redirect_to diary_books_path
    else
      render :new
    end
  end

  def index
     @diary_books = current_customer.diary_books
     #@diary_books = current_customer.diary_books.includes(:customer)
  end

  def show
    @diary_book = current_customer.diary_books.find(params[:id])
  end


  def destroy
     @diary_book = current_customer.diary_books.find(params[:id])
     @diary_book.destroy
    redirect_to diary_books_path
  end

  def edit
    @diary_book = current_customer.diary_books.find(params[:id])
  end

  def update
    @diary_book = current_customer.diary_books.find(params[:id])
      if @diary_book.update(diary_book_params)
      flash[:notice] = "日記帳を更新しました。"
      redirect_to diary_book_path(@diary_book)
      else
      render :edit
      end
  end

  private
    def diary_book_params
      params.require(:diary_book).permit(:title,:status, tag_ids: [])
    end
end
