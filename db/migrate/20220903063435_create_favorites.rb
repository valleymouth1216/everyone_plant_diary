# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :customer_id, null: false
      t.integer :diary_date_id, null: false
      t.timestamps
    end
  end
end
