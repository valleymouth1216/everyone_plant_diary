# frozen_string_literal: true

class CreateDiaryTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_tag_relations do |t|
      t.references :diary_book, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
