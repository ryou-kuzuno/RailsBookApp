class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comments
      t.integer :user_id
      t.integer :bookstore_id
      t.boolean :displayable

      t.timestamps
    end
  end
end
