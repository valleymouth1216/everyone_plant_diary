class Public::FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(customer_id: current_customer.id)
  end

  def create
    diary_date = DiaryDate.find(params[:customer_diary_book_id])
    favorite = current_customer.favorites.new(diary_date_id: diary_date.id)
    favorite.save
    redirect_to  customer_customer_diary_book_path(diary_date.diary_book.customer.id,diary_date)
  end

  def destroy
    diary_date = DiaryDate.find(params[:customer_diary_book_id])
    favorite = current_customer.favorites.find_by(diary_date_id: diary_date.id)
    favorite.destroy
    redirect_to customer_customer_diary_book_path(diary_date.diary_book.customer.id,diary_date)
  end
end
