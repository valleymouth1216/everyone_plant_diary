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
    #binding.pry
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)
    #byebug
    @diary_dates = DiaryDate.select do |d|
     d.start_time.to_date == date && d.status == true && d.status_admin == true && d.diary_book.status == true && d.diary_book.status_admin == true
   end

    if params[:search] == ''
    @diary_dates.sort
    elsif params[:search] == 'newpost'
      #@diary_dates.sort { |a, b| b[:created_at].to_time.to_i <=> a[:created_at].to_time.to_i }
      @diary_dates.sort do |a, b|
        b[:created_at].in_time_zone.to_i <=> a[:created_at].in_time_zone.to_i
     #binding.pry
      end
    elsif params[:search] == 'oldpost'
      #@diary_dates.sort { |a, b| a[:created_at].to_time.to_i <=> b[:created_at].to_time.to_i }
      @diary_dates.sort do |a, b|
        a[:created_at].in_time_zone.to_i <=> b[:created_at].in_time_zone.to_i
      end
    end

  #arr = []
  #Diary.each do |d|
  #   if d.start_time.to_date == date
  #     arr.push(d)
  #   end
  # end
  end

end
