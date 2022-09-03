class CreateDiaryComments < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_comments do |t|
      t.integer :customer_id,null: false
      t.integer :diary_date_id,null: false
      t.text :comment,null: false
      t.timestamps
    end
  end
end
