class Admin::DiaryBooksController < ApplicationController
    before_action :authenticate_admin!

  def index
    @customer = Customer.find(params[:customer_id])
    @diary_books = @customer.diary_books.page(params[:page]).per(10)
    #binding.pry
    if params[:tag_ids]
      @diary_books = []
      params[:tag_ids].each do |key, value|
        #binding.pry
        @diary_books += Tag.find_by(name: key).diary_books.where(customer_id: @customer) if value == "1"
      end
      @diary_books.uniq!
      @diary_books = Kaminari.paginate_array(@diary_books).page(params[:page])
    #else params[:tag_ids].all? {|key,value| value =="0"}
    #   @diary_books = current_customer.diary_books.page(params[:page]).per(10)
    end
    if params[:diary_book].present?
      @diary_book = @customer.diary_books.find(params[:diary_book])
      @diary_dates = @diary_book.diary_dates
      @diary_date = @diary_book.diary_dates.order(:updated_at).last
    end
  end

  def show
    @diary_book =DiaryBook.find(params[:id])
  end

  def update
    @diary_book = DiaryBook.find(params[:id])
      if @diary_book.update(diary_book_params)
      flash[:notice] = "日記帳の公開ステータスを更新しました。"
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
