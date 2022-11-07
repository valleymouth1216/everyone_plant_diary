# frozen_string_literal: true

class Public::DiaryDatesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_diary_book, only: [:new, :create, :show, :edit, :destroy, :update,:search_date]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @diary_date = DiaryDate.new
  end

  def create
    @diary_date = DiaryDate.new(diary_params)

    @diary_dates = @diary_book.diary_dates
    # byebug
    # binding.pry
    @diary_date.diary_book_id = @diary_book.id

    if @diary_date.save
      flash[:notice] = "日記を作成しました。"
      redirect_to diary_book_diary_date_path(@diary_book, @diary_date)
    else
      render :new
    end
  end

  def index
    @diary_books = current_customer.diary_books.order(created_at: :desc).page(params[:page]).per(10)
    if params[:tag_ids]
      @diary_books = []
      params[:tag_ids].each do |key, value|
        @diary_books += Tag.find_by(name: key).diary_books.where(customer_id: current_customer.id).order(created_at: :desc) if value == "1"
      end
      @diary_books.uniq!
      if @diary_books == []
        @diary_books = current_customer.diary_books.page(params[:page]).per(10)
        flash[:notice] = "タグが設定されていませんので、すべて表示します。"
      else
        @diary_books = Kaminari.paginate_array(@diary_books).page(params[:page])
      end
    end
    if params[:diary_book].present?
      @diary_book = current_customer.diary_books.find(params[:diary_book])
      @diary_dates = @diary_book.diary_dates
      @diary_date_latest_date = @diary_book.diary_dates.order(:updated_at).last
    end
  end

  def show
    diary_date = DiaryDate.find(params[:id])
    if @diary_book.id == diary_date.diary_book_id
      @diary_date = @diary_book.diary_dates.find(params[:id])
    else
      redirect_to calendar_diaries_path
      flash[:notice] = "この日付はこの日記帳ではありません。"
    end
    @diary_comment = DiaryComment.new
  end

  def edit
    diary_date = DiaryDate.find(params[:id])
    if @diary_book.id == diary_date.diary_book_id
      @diary_date = @diary_book.diary_dates.find(params[:id])
    else
      redirect_to calendar_diaries_path
      flash[:notice] = "この日付はこの日記帳ではありません。"
    end
  end

  def destroy
    @diary_date = @diary_book.diary_dates.find(params[:id])
    @diary_date_redirect = @diary_book.diary_dates.find(params[:id])
    @diary_date.destroy
    flash[:notice] = "#{@diary_date_redirect.start_time.strftime('%Y年%m月%d日')}の日記を削除しました。"
    redirect_to diary_books_diaries_path(diary_book: @diary_date_redirect.diary_book.id)
  end

  def update
    @diary_date = @diary_book.diary_dates.find(params[:id])
    if params[:diary_date][:image_ids]
      params[:diary_date][:image_ids].each do |image_id|
        image = @diary_date.diary_images.find(image_id)
        image.purge
      end
    end
    if @diary_date.update(diary_params)
      flash[:notice] = "日記を更新しました。"
      redirect_to diary_book_diary_date_path(@diary_book, @diary_date)
    else
      render :edit
    end
  end

  def search_date
     @diary_book = DiaryBook.find(params[:diary_book_id])
    if params[:start_date] == "" || params[:end_date] == ""
      redirect_to diary_books_diaries_path(diary_book: @diary_book.id)
      flash[:alert] = "日付が選択されていません。"
    else
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @search_diary_dates = @diary_book.diary_dates.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("start_time DESC").page(params[:page]).per(10)
      @search_diary_dates_count = @diary_book.diary_dates.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day)
    end
  end

  private
    def set_diary_book
      diary_book = DiaryBook.find(params[:diary_book_id])
      if diary_book.customer_id == current_customer.id
        @diary_book = current_customer.diary_books.find(params[:diary_book_id])
      else
        redirect_to calendar_diaries_path
        flash[:notice] = "ほかのユーザの日記帳です。"
      end
    end

    def record_not_found
      redirect_to diary_books_path
      flash[:notice] = "存在しない日記もしくは他のユーザの日記です。"
    end

    def diary_params
      params.require(:diary_date).permit(:start_time, :status, :body, :temperature, :weather, diary_images: [])
    end
end
