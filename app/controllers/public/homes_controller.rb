# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def top
  end

  def about
  end

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @result = search_for(@model, @content, @method)
    if @model == "customer"
      @customers = search_for(@model, @content, @method)
    else
      @diary_books = search_for(@model, @content, @method)
    end
  end

  private
    def search_for(model, content, method)
      if @content == ""
      else
        if model == "diary_books"
          if  method == "perfect"
            DiaryBook.where(title: content).where(status: true, status_admin: true).order(created_at: :desc)
          else
            DiaryBook.where("title LIKE ?", "%" + content + "%").where(status: true, status_admin: true).order(created_at: :desc)
          end
        elsif model == "customer"
          if  method == "perfect"
            Customer.where(name: content).where(is_deleted: false).order(created_at: :desc)
          else
            Customer.where("name LIKE ?", "%" + content + "%").where(is_deleted: false).order(created_at: :desc)
          end
        else
          []
        end
      end
    end
end
