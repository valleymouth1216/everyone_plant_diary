class Public::CalendarDiariesController < ApplicationController
    before_action :authenticate_customer!,except: [:index]

  def index
   #@diary_dates = DiaryDate.where(status_admin: true,status: true).joins(:diary_book).where(status_admin: true,status: true)
    @diary_dates = DiaryDate.joins(:diary_book).where(status_admin: true,status: true, diary_books: {status_admin: true,status: true})
  end

  def filter_by_date
    date_arr = params[:date].split("-")
    @date_year = date_arr[0]
    @date_month = date_arr[1]
    @date_date = date_arr[2]
    #binding.pry
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)


  if params[:search] == 'oldpost'
    @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at ASC")
  elsif params[:search] == 'favoritepost'
    @diary_dates = DiaryDate.joins(:diary_book,:favorite).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("count(diary_date_id) ASC")
    #@diary_dates = DiaryDate.find(Favorite.group(:diary_date_id).order("count(diary_date_id) ASC").pluck(:diary_date_id))
  else
    @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC")
  end



  #arr = []
  #Diary.each do |d|
  #   if d.start_time.to_date == date
  #     arr.push(d)
  #   end
  # end
  end

end
