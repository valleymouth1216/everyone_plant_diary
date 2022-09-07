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
    @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day).order("created_at DESC")
  end
end
