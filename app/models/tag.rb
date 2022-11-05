# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :diary_tag_relations, dependent: :destroy
  has_many :diary_books, through: :diary_tag_relations


  validates :name, uniqueness: true, presence: true
end
