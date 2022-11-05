# frozen_string_literal: true

class DiaryComment < ApplicationRecord
  belongs_to :customer
  belongs_to :diary_date

  validates :comment, presence: true
end
