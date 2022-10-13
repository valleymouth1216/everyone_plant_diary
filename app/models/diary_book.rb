class DiaryBook < ApplicationRecord
    belongs_to :customer
    has_many :diary_tag_relations, dependent: :destroy
    has_many :tags, through: :diary_tag_relations
    has_many :diary_dates, dependent: :destroy


    def order_update_last
      diary_dates.order(:updated_at).last
    end

    def order_update_last_user
      diary_dates.order(:updated_at).last
    end

    def order_update_first_user
      diary_dates.order(:updated_at).first
    end
    def order_update_last_custmoter
      diary_dates.where(status_admin: true,status: true).order(:updated_at).last
    end

    def order_update_first_custmoter
      diary_dates.where(status_admin: true,status: true).order(:updated_at).first
    end

         validates :title, presence: true
         validates :tag_ids, presence: true
end
