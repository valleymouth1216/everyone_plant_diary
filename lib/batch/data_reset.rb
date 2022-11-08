class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    customer = Customer.find_by(email: "guest@example.com")
      customer.diary_comments.destroy_all
      customer.favorites.destroy_all
      diary_books = customer.diary_books
      diary_books.each do |diary_book|
        diary_book.diary_dates.destroy_all
      end
      diary_books = customer.diary_books.destroy_all
       p "投稿を全て削除しました"
  end
end