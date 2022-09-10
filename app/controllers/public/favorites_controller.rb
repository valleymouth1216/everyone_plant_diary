class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!


  def index
    #@favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true}).order("created_at DESC")

    if params[:order] == 'oldfavorite'
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true}).order("created_at ASC").page(params[:page]).per(10)
    elsif params[:order] == 'newpost'
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true}).order("start_time DESC").page(params[:page]).per(10)
      #@diary_dates = DiaryDate.find(Favorite.group(:diary_date_id).order("count(diary_date_id) ASC").pluck(:diary_date_id))
    elsif params[:order] == 'oldpost'
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true}).order("start_time ASC").page(params[:page]).per(10)
    else
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true}).order("created_at DESC").page(params[:page]).per(10)
    end
    @order = params[:order]
    @favorites_count = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: {status_admin: true,status: true})
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
