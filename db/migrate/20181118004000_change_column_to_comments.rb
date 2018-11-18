class ChangeColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :book_id, :bookstore_id
  end
end
