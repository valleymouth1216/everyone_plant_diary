class DiaryDate < ApplicationRecord

    belongs_to :diary_book
    has_many_attached:diary_images
    has_many :diary_comments, dependent: :destroy
    #has_one :customer, through: :diary_book

    enum weather: { not_set: 0, sunny: 1, cloudy: 2, rain: 3, snow: 4, typhoon: 5}

    validates :start_time, presence: true, uniqueness: { scope: :diary_book_id }
    validates :body, presence: true
   # validate :image_type
    def self.count_by_date(date)
       where(start_time: Time.zone.parse(date.to_s), status: true,status_admin: true).joins(:diary_book).where(status_admin: true,status: true).count
    end

    def self.count_by_date_admin(date)
       where(start_time: Time.zone.parse(date.to_s)).count
    end


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
