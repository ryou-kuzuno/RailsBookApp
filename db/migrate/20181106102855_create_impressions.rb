class CreateImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :impressions do |t|
      t.text :story
      t.text :impressions
      t.integer :user_id
      t.integer :bookstore_id

      t.timestamps
    end
      # add_index :user_book_id, [:user_id, :book_id], unique: true
      # add_index :user_id, :book_id
  end
end
