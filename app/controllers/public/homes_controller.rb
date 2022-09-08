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
    if model == 'diary_books'
      if  method == 'perfect'
        DiaryBook.where(title: content).where(status: true,status_admin: true)
      else
        DiaryBook.where('title LIKE ?', '%' + content + '%').where(status: true,status_admin: true)
      end
    elsif model == 'customer'
      if  method == 'perfect'
        Customer.where(name: content).where(is_deleted: false)
      else
        Customer.where('name LIKE ?', '%' + content + '%').where(is_deleted: false)
      end
    else
      [] # 空配列を返す
    end
  end
end
