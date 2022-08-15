class CreateDiaryBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_books do |t|
      t.integer :customer_id,null: false, default: ""
      t.string :title,null: false, default: ""
      t.boolean :status, null: false, default: false
      t.boolean :status_admin, null: false, default: false
      t.text :introduction
      t.timestamps
    end
  end
end
