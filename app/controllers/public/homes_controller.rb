class Public::HomesController < ApplicationController
  def top
  end

  def about
  end

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'customer'
      if method == 'forward'
        Customer.where('name LIKE ?', content + '%').where(is_deleted: false)
      elsif method == 'backward'
        Customer.where('name LIKE ?', '%' + content).where(is_deleted: false)
      elsif method == 'perfect'
        Customer.where(name: content).where(is_deleted: false)
      else # partial
        Customer.where('name LIKE ?', '%' + content + '%').where(is_deleted: false)
      end
    elsif model == 'diary_books'
      if method == 'forward'
        DiaryBook.where('title LIKE ?', content + '%').where(status: true,status_admin: true)
      elsif method == 'backward'
        DiaryBook.where('title LIKE ?', '%' + content).where(status: true,status_admin: true)
      elsif method == 'perfect'
        DiaryBook.where(title: content).where(status: true,status_admin: true)
      else # partial
        DiaryBook.where('title LIKE ?', '%' + content + '%').where(status: true,status_admin: true)
      end
    else
      [] # 空配列を返す
    end
  end
end
