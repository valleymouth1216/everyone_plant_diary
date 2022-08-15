class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :customer_id,null: false, default: ""
      t.integer :diary_id,null: false, default: ""
      t.timestamps
    end
  end
end
