# frozen_string_literal: true

class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @tags = Tag.page(params[:page]).per(10)
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path
      flash[:notice] = "タグを追加しました."
    else
      render :index
    end
  end

  def index
    @tags = Tag.page(params[:page]).per(10)
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
      flash[:notice] = "タグ名を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    @tag_destroy = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
    flash[:notice] = " ”#{@tag_destroy.name}”のタグを削除しました。"
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
