class Public::CustomerDiaryBooksController < ApplicationController
  before_action :authenticate_customer!


  def index
    @customer = Customer.find(params[:customer_id])
    if @customer.is_deleted == true
       flash[:alert] =  "このユーザは退会されています。"
       redirect_to calendar_diaries_path and return
    end
    @diary_books = @customer.diary_books.where(status_admin: true,status: true).order(created_at: :desc).page(params[:page]).per(10)
    if params[:tag_ids]
      @diary_books = []
      params[:tag_ids].each do |key, value|
        @diary_books += Tag.find_by(name: key).diary_books.where(customer_id: @customer,status_admin: true,status: true).order(created_at: :desc) if value == "1"
      end
      @diary_books.uniq!
      if @diary_books == []
        @diary_books = @customer.diary_books.where(status_admin: true,status: true).order(created_at: :desc).page(params[:page]).per(10)
        flash[:notice] = "タグが設定されていませんので、すべて表示します。"
      else
        @diary_books = Kaminari.paginate_array(@diary_books).page(params[:page])
      end
    end
    if params[:diary_book].present?
     @customer = Customer.find(params[:customer_id])
     @diary_book = @customer.diary_books.find(params[:diary_book])
     @diary_dates = @diary_book.diary_dates.where(status_admin: true,status: true)
     @diary_date_latest_date = @diary_book.diary_dates.where(status_admin: true,status: true).order(:updated_at).last
     redirect_to(diary_books_diaries_path(diary_book: @diary_book.id)) if current_customer.id == @diary_book.customer.id
     unless @diary_book.status_admin == true && @diary_book.status == true
       flash[:alert] =  "この日記帳は非公開のため表示出来ません。"
       redirect_to calendar_diaries_path and return

     end
    end

  end

  def show
    @customer =Customer.find(params[:customer_id])
    @diary_date = DiaryDate.find(params[:id])
    @diary_comment = DiaryComment.new
    redirect_to(diary_book_diary_date_path(@diary_date.diary_book,@diary_date)) if current_customer.id == @diary_date.diary_book.customer.id
    unless @diary_date.status_admin == true && @diary_date.status == true && @diary_date.diary_book.status_admin == true && @diary_date.diary_book.status == true
           flash[:alert] =  "この日記帳の日付の内容は非公開のため表示出来ません"
       redirect_to calendar_diaries_path and return
    end
    if @customer.is_deleted == true
       flash[:alert] =  "このユーザは退会されています。"
       redirect_to calendar_diaries_path and return
    end
  end



end
