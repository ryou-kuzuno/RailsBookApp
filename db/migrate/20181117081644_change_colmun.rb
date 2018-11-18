class ChangeColmun < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :book_id, :bookstore_id
  end
end
