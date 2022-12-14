# frozen_string_literal: true

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    # @customers = Customer.where(is_deleted: false).order("RANDOM()").page(params[:page]).per(10)
    @customers = Customer.where(is_deleted: false).order("RAND()").page(params[:page]).per(10)
  end

  def show
    if params[:id] == current_customer.id.to_s
      redirect_to my_page_path
    else
      @customer = Customer.find(params[:id])
      if @customer.is_deleted == true
        flash[:alert] = "このユーザは退会されています。"
        redirect_to calendar_diaries_path and return
      end
      @customer_diary_books = @customer.diary_books.where(status_admin: true, status: true).order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def my_page
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.email == "guest@example.com"
      redirect_to my_page_path
      flash[:notice] = "ゲストユーザーはユーザー情報の編集ができません。"
    else
      if @customer.update(customer_params)
        flash[:notice] = "登録情報を更新しました。"
        redirect_to my_page_path
      else
        @customer.reload
        render :edit
      end
    end
  end

  def withdraw
    @customer = current_customer
    if @customer.email == "guest@example.com"
      redirect_to my_page_path
      flash[:notice] = "ゲストユーザーは退会できません。"
    else
      @customer.diary_comments.destroy_all
      @customer.favorites.destroy_all
      @customer.update(is_deleted: true)
      diary_books = @customer.diary_books.where(customer_id: current_customer.id)
      diary_books.each do |diary_book|
        diary_book.update(status: false)
        diary_book.diary_dates.update_all(status: false)
      end
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:email, :name, :profile_image)
    end
end
