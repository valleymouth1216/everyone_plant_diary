# frozen_string_literal: true

class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!


  def index
    if params[:order] == "oldfavorite"
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: { status_admin: true, status: true }).order("created_at ASC").page(params[:page]).per(10)
      @order = "最古のいいね順"
    elsif params[:order] == "newpost"
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: { status_admin: true, status: true }).order("start_time DESC").page(params[:page]).per(10)
      @order = "新しい日付順"
    elsif params[:order] == "oldpost"
      @order = "古い日付順"
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: { status_admin: true, status: true }).order("start_time ASC").page(params[:page]).per(10)
    else
      @order = "最新のいいね順"
      @favorites = Favorite.joins(:diary_date).where(customer_id: current_customer.id, diary_dates: { status_admin: true, status: true }).order("created_at DESC").page(params[:page]).per(10)
    end
    @favorites_count = Favorite.includes(:diary_date, :customer).joins(:diary_date).where(customer_id: current_customer.id, diary_dates: { status_admin: true, status: true })
  end

  def create
    diary_date = DiaryDate.find(params[:customer_diary_book_id])
    favorite = current_customer.favorites.new(diary_date_id: diary_date.id)
    favorite.save
    redirect_to  customer_customer_diary_book_path(diary_date.diary_book.customer.id, diary_date)
  end

  def destroy
    diary_date = DiaryDate.find(params[:customer_diary_book_id])
    favorite = current_customer.favorites.find_by(diary_date_id: diary_date.id)
    favorite.destroy
    redirect_to customer_customer_diary_book_path(diary_date.diary_book.customer.id, diary_date)
  end
end
