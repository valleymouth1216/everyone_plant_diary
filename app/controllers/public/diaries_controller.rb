class Public::DiariesController < ApplicationController
  def new
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =Diary.new
    @diary_image = @diary.diary_images.build
  end

  def create
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary = Diary.new(diary_params)

    @diarys = @diary_book.diaries
   #@diary_images = @diarys.diary_images.build
    #byebug
    # binding.pry
    @diary.diary_book_id = @diary_book.id

    if @diary.save
#      if params[diary_images:[]].present?
#        params[diary_images:[]].each do |diary_image|
#          diary_image.id=@diary_book.id
#      binding.pry
#          diary_image.save
#        end
#      end

      flash[:notice] = "日記を作成しました。"
      redirect_to diary_book_diaries_path(@diary_book)
    else
      render :new
    end
  end
  

  def index
    @diary_books = current_customer.diary_books.find(params[:diary_book_id])
    #@diary_books = current_customer.diary_books.where(:id => params[:diary_book_id]).first
    @diarys = @diary_books.diaries

  end

  def show
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])


  end

  def edit
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
  end

  def update
    @diary_book = current_customer.diary_books.find(params[:diary_book_id])
    @diary =@diary_book.diaries.find(params[:id])
      if @diary.update(diary_params)
      flash[:notice] = "日記を更新しました。"
      redirect_to diary_book_diaries_path(@diary_book)
      else
      render :edit
      end
  end

    private
    def diary_params
      params.require(:diary).permit(:date,:status,:body,:temperature,:weather,diary_images:[])
      #params.require(:diary).permit(:date,:status,:body,:temperature,:weather,diary_images_attributes: [diary_images:[]])
    end
end

