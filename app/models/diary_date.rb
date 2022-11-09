# frozen_string_literal: true

class DiaryDate < ApplicationRecord
  belongs_to :diary_book
  has_many_attached :diary_images
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validate :image_type

  enum weather: { not_set: 0, sunny: 1, cloudy: 2, rain: 3, snow: 4, typhoon: 5 }

  validates :start_time, presence: true, uniqueness: { scope: :diary_book_id }
  validates :body, presence: true
  validates :temperature, numericality: { greater_than: -100, less_than: 100 }, allow_blank: true



  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.count_by_date(date)
    joins(:diary_book).where(start_time: Time.zone.parse(date.to_s).at_beginning_of_day...Time.zone.parse(date.to_s).at_end_of_day, status_admin: true, status: true, diary_books: { status_admin: true, status: true })
  end

  def self.count_by_date_admin(date)
    where(start_time: Time.zone.parse(date.to_s)).count
  end

  private

  def image_type
    if diary_images.each do |diary_image|
      if !diary_image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:diary_images, "JPEGまたはPNG形式を選択してアップロードしてください")
      end
      end
    end
  end
end
