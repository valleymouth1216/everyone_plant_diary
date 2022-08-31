class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @diaries = Diary.all
  end

  def filter_by_date
    date_arr = params[:date].split("-")
    @date_year = date_arr[0]
    @date_month = date_arr[1]
    @date_date = date_arr[2]
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)
    #byebug
    @diaries = Diary.select do |d|
     d.start_time.to_date == date #&& d.status ==true && d.status_admin ==false && d.diary_book.status ==true && d.diary_book.status_admin ==false
   end
  end
end
