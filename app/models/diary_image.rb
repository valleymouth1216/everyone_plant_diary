class DiaryImage < ApplicationRecord
  belongs_to :diary
  has_many_attached :diary_images
  has_one_attached :diary_image


#  def get_diary_image(width, height)
#    diary_image.variant(resize_to_limit: [width, height]).processed
#  end
end
