class Public::CalendarDiariesController < ApplicationController
    before_action :authenticate_customer!,except: [:index]

  def index
    @diary_dates = DiaryDate.where(status_admin: true,status: true).joins(:diary_book).where(status_admin: true,status: true)
  end

  def filter_by_date
    date_arr = params[:date].split("-")
    @date_year = date_arr[0]
    @date_month = date_arr[1]
    @date_date = date_arr[2]
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)
    #byebug
    @diary_dates = DiaryDate.select do |d|
     d.start_time.to_date == date && d.status == true && d.status_admin == true && d.diary_book.status == true && d.diary_book.status_admin == true
   end

  #arr = []
  #Diary.each do |d|
  #   if d.start_time.to_date == date
  #     arr.push(d)
  #   end
  # end
  end

end
