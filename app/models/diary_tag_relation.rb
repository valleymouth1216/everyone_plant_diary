class DiaryTagRelation < ApplicationRecord
  belongs_to :diary_book
  belongs_to :tag
end
