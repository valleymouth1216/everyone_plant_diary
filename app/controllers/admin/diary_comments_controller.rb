class Admin::DiaryCommentsController < ApplicationController

    def destroy
    @diary_date = DiaryDate.find(params[:diary_date_id])
    DiaryComment.find(params[:id]).destroy
        redirect_to admin_diary_book_diary_date_path(params[:diary_book_id],params[:diary_date_id])
    end

end
