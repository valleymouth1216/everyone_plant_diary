class CreateDiaryImages < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_images do |t|
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
