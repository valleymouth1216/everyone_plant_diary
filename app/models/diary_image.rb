class DiaryImage < ApplicationRecord
  belongs_to :diary

  has_one_attached :diary_image


#  def get_diary_image(width, height)
#    diary_image.variant(resize_to_limit: [width, height]).processed
#  end
  validate :image_type

  def image_type
      if !diary_image.content_type.in?(%('image/jpec image/png'))
      errors.add(:diary_images, "JPEGまたはPNG形式を選択してアップロードしてください")
      end
  end

end
