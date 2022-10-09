class Public::CalendarDiariesController < ApplicationController
    before_action :authenticate_customer!,except: [:index]

  def index
    @diary_dates = DiaryDate.joins(:diary_book).where(status_admin: true,status: true, diary_books: {status_admin: true,status: true})
    @diary_dates_first= DiaryDate.joins(:diary_book).where(status_admin: true,status: true, diary_books: {status_admin: true,status: true}).first
  end

  def filter_by_date
    date_arr = params[:date].split("-")
    @date_year = date_arr[0]
    @date_month = date_arr[1]
    @date_date = date_arr[2]
    #binding.pry
    date =  Date.new(date_arr[0].to_i,date_arr[1].to_i, date_arr[2].to_i)

    if params[:tag_ids]&.values&.include?("1")
      @diary_books = []
      params[:tag_ids].each do |key, value|
        @diary_books += Tag.find_by(name: key).diary_books.where(status: true, status_admin: true).order(created_at: :desc) if value == "1"
      end
      @diary_books.uniq!
      @diary_dates = []
      @diary_books.each do |diary_book|
        @diary_dates += diary_book.diary_dates.where(start_time: date.at_beginning_of_day...date.at_end_of_day,status_admin: true,status: true).order("created_at DESC")
      end
      @diary_dates.uniq!
      @diary_dates = Kaminari.paginate_array(@diary_dates).page(params[:page]).per(10)
        if @diary_dates == []
          @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC").page(params[:page]).per(10)
          flash[:notice] = "タグ検索したタグがありませんので、すべて表示します。"
        end
    else
      @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC").page(params[:page]).per(10)
      redirect_to calendar_diaries_path,  notice: "この日付で公開できる日記がありません。" if @diary_dates.blank?
    end

    if params[:order] == 'oldpost'
      @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at ASC").page(params[:page]).per(10)
      @order = "古い順"
    elsif params[:order] == 'favoritepost'
      @diary_dates = Kaminari.paginate_array(DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day,status: true, status_admin: true, diary_books: {status_admin: true,status: true}).sort {|a, b| b.favorites.size <=> a.favorites.size }).page(params[:page]).per(10)
      @order = "いいね順"
    elsif params[:order] == 'newpost'
      @diary_dates = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC").page(params[:page]).per(10)
      @order = "新しい順"
    end
      @diary_dates_count = DiaryDate.joins(:diary_book).where(start_time: date.at_beginning_of_day...date.at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true})

  # binding.pry

  end

  def search_date
    if params[:start_date] == "" ||params[:end_date] == ""
      flash[:alert] = "日付が選択されていません。"
      redirect_to calendar_diaries_path
    else
     # binding.pry
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      #@search_diary_date = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("start_time DESC").page(params[:page]).per(10)
      #@search_diary_date = DiaryDate.joins(:diary_book).where(start_time: start_time..end_time).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC")


    if params[:tag_ids]&.values&.include?("1")
      @diary_books = []
      params[:tag_ids].each do |key, value|
        @diary_books += Tag.find_by(name: key).diary_books.where(status: true, status_admin: true).order(created_at: :desc) if value == "1"
      end
        @diary_books.uniq!
        @search_diary_dates = []
        @diary_books.each do |diary_book|
        @search_diary_dates += diary_book.diary_dates.where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day,status_admin: true,status: true)
      end
      @search_diary_dates.uniq!
        if @search_diary_dates == []
          @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).page(params[:page]).per(10)
          flash[:notice] = "タグ検索したタグがありませんので、すべて表示します。"
        end
      @search_diary_dates = Kaminari.paginate_array(@search_diary_dates).page(params[:page]).per(10)
    else
      @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day, status: true, status_admin: true, diary_books: {status_admin: true,status: true}).page(params[:page]).order("start_time DESC").per(10)
    end

      if params[:order] == 'olddate'
        @order_diary_date = "古い日付順"
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("start_time ASC").page(params[:page]).per(10)
      elsif params[:order] == 'newpost'
        @order_diary_date = "最新の投稿順"
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at DESC").page(params[:page]).per(10)
      elsif params[:order] == 'oldpost'
        @order_diary_date = "古い投稿順"
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("created_at ASC").page(params[:page]).per(10)
      elsif params[:order] == 'newdate'
        @order_diary_date = "最新の日付順"
        @search_diary_dates = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true}).order("start_time DESC").page(params[:page]).per(10)
      end
      @search_diary_dates_count = DiaryDate.joins(:diary_book).where(start_time: Time.zone.parse(@start_date).at_beginning_of_day...Time.zone.parse(@end_date).at_end_of_day).where(status: true,status_admin: true, diary_books: {status_admin: true,status: true})
    end
  end

end
