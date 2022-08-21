class Diary < ApplicationRecord
    belongs_to :diary_book

    has_many_attached:diary_images

    enum weather: { not_set: 0, sunny: 1, cloudy: 2, rain: 3, snow: 4, typhoon: 5}

    validates :date, presence: true, uniqueness: { scope: :diary_book_id }
    validates :body, presence: true
    validate :image_type

#  def get_diary_image(width, height)
#  return self.diary_images[input].variant(resize_to_limit: [width, height]).processed
#  end

  private

  def image_type
    if diary_images.each do |diary_image|
      if !diary_image.content_type.in?(%('image/jpec image/png'))
        errors.add(:diary_images, "JPEGまたはPNG形式を選択してアップロードしてください")
      end
      end
    end
  end

end
