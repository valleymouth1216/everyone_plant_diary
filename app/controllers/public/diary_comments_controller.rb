class Public::DiaryCommentsController < ApplicationController

  def create
   # binding.pry
    @diary_date = DiaryDate.find(params[:customer_diary_book_id])
    diary_comment = current_customer.diary_comments.new(diary_comment_params)
    #binding.pry
    diary_comment.diary_date_id = @diary_date.id
    if diary_comment.save
      if current_customer.id ==  @diary_date.diary_book.customer.id
        redirect_to diary_book_diary_date_path(@diary_date.diary_book,@diary_date)
        flash[:notice] = "コメントしました。"
      else
        redirect_to customer_customer_diary_book_path(@diary_date.diary_book.customer.id,@diary_date)
        flash[:notice] = "コメントしました。"
      end
    else
      if current_customer.id == @diary_date.diary_book.customer_id
        redirect_to diary_book_diary_date_path(@diary_date.diary_book,@diary_date)
      else
        redirect_to customer_customer_diary_book_path(@diary_date.diary_book.customer.id,@diary_date)
      end
     flash[:alert] = "コメントを入力してください"
    end
  end

  def destroy
    @diary_date = DiaryDate.find(params[:customer_diary_book_id])
    diary_comment = @diary_date.diary_comments.find(params[:id])
    if current_customer.id == diary_comment.customer_id
    diary_comment.destroy
      if current_customer.id ==  @diary_date.diary_book.customer.id
        redirect_to diary_book_diary_date_path(@diary_date.diary_book,@diary_date)
        flash[:notice] = "コメント削除しました。"
      else
        redirect_to customer_customer_diary_book_path(params[:customer_id],params[:customer_diary_book_id])
        flash[:notice] = "コメント削除しました。"
      end
     else
      if current_customer.id ==  @diary_date.diary_book.customer.id
        redirect_to diary_book_diary_date_path(@diary_date.diary_book,@diary_date)
        flash[:alert] = "他のユーザのコメントを削除できません。"
      else
        redirect_to customer_customer_diary_book_path(params[:customer_id],params[:customer_diary_book_id])
        flash[:alert] = "他のユーザのコメントを削除できません。"
      end
    end

  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:comment)
  end

end
