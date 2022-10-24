class DiaryDate < ApplicationRecord

    belongs_to :diary_book
    has_many_attached:diary_images
    has_many :diary_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    enum weather: { not_set: 0, sunny: 1, cloudy: 2, rain: 3, snow: 4, typhoon: 5}

    validates :start_time, presence: true, uniqueness: { scope: :diary_book_id }
    validates :body, presence: true
    validates :temperature, numericality: {greater_than: -100,less_than: 100}, allow_blank: true



    def favorited_by?(customer)
      favorites.exists?(customer_id: customer.id)
    end

    def self.count_by_date(date)
      joins(:diary_book).where(start_time: Time.zone.parse(date.to_s).at_beginning_of_day...Time.zone.parse(date.to_s).at_end_of_day,status_admin: true,status: true, diary_books: {status_admin: true,status: true})
      # where(start_time: Time.zone.parse(date.to_s), status: true,status_admin: true).joins(:diary_book).where(status_admin: true,status: true).count
    end

    def self.count_by_date_admin(date)
       where(start_time: Time.zone.parse(date.to_s)).count
    end

  private



end
