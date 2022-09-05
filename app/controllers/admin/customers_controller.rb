class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer =Customer.find(params[:id])
    @diary_books =@customer.diary_books

  end

  def edit
    @customer =Customer.find(params[:id])

  end

  def update
    @customer =Customer.find(params[:id])
    if @customer.update(customer_params)
      if @customer.is_deleted ==true
         @customer.diary_comments.destroy_all
         @customer.favorites.destroy_all
         diary_books =  @customer.diary_books.where(customer_id: @customer.id)
         diary_books.each do |diary_book|
           diary_book.update(status_admin: false)
           diary_book.diary_dates.update_all(status_admin: false)
         end
      end
    flash[:notice] = "登録情報を更新しました。"
    redirect_to admin_customer_path(@customer)
    else
    render:edit
    end
  end


  private


  def customer_params
    params.require(:customer).permit(:email,:name,:profile_image,:is_deleted)
  end
end
