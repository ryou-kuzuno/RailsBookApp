class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :likes # 要らないはず
      t.integer :user_id
      t.integer :bookstore_id
      t.integer :impression_id

      t.timestamps
    end
  end
end
