# frozen_string_literal: true

class CreateDiaryDates < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_dates do |t|
      t.integer :diary_book_id, null: false
      t.datetime :start_time, null: false
      t.integer :weather, default: 0, null: false
      t.integer :temperature
      t.text :body, null: false
      t.boolean :status, null: false, default: false
      t.boolean :status_admin, null: false, default: true
      t.timestamps
    end
  end
end
