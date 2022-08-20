class Diary < ApplicationRecord
    belongs_to :diary_book


         validates :date, presence: true, uniqueness: { scope: :diary_book_id }
         validates :body, presence: true

    enum weather: { not_set: 0, sunny: 1, cloudy: 2, rain: 3, snow: 4, typhoon: 5}


end
