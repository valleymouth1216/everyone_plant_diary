class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @diary_dates = DiaryDate.all
    @diary_dates_release = DiaryDate.joins(:diary_book).where(status_admin: true,status: true, diary_books: {status_admin: true,status: true})
  end

  def filter_by_date
    date_arr = params[:date].split("-")
    @date_year = date_arr[0]
    @date_month = date_arr[1]
    @date_date = date_arr[2]
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)
    #byebug
    if params[:order] == 'oldpost'
      @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day).order("created_at ASC").page(params[:page]).per(10)
    elsif params[:order] == 'favoritepost'
      @diary_dates = DiaryDate.joins(:diary_book,:favorite).where(start_time: date.at_beginning_of_day...date.at_end_of_day).order("count(diary_date_id) ASC").page(params[:page]).per(10)
    else
      @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day).order("created_at DESC").page(params[:page]).per(10)
    end
      @diary_dates_count = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day)
      @order = params[:order]
  end

  def search_date
    if params[:start_date] == "" ||params[:end_date] == ""
      flash[:notice] = "日付が選択されていません。"
      redirect_to calendar_diaries_path
    else
     # binding.pry
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @search_diary_date = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("start_time DESC").page(params[:page]).per(10)

      @order_diary_date = params[:order]
      if params[:order] == 'olddate'
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("start_time ASC").page(params[:page]).per(10)
      elsif params[:order] == 'newpost'
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("created_at DESC").page(params[:page]).per(10)
      elsif params[:order] == 'oldpost'
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("created_at ASC").page(params[:page]).per(10)
      else
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).order("start_time DESC").page(params[:page]).per(10)
      end
      @search_diary_dates_count = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day)
      #@search_diary_dates_release_count = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true})
    end
  end
end
