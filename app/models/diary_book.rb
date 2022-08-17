class DiaryBook < ApplicationRecord
    belongs_to :customer
    has_many :diary_tag_relations, dependent: :destroy
    has_many :tags, through: :diary_tag_relations


    has_many :diaries, dependent: :destroy
end
