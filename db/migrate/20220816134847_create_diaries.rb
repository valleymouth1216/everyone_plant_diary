class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.integer :diary_book_id,null: false
      t.datetime :date,null: false
      t.integer :weather,default: 0, null: false
      t.integer :temperature
      t.text :body,null: false, default: ""
      t.boolean :status, null: false, default: false
      t.boolean :status_admin, null: false, default: false
      t.timestamps
    end
  end
end
