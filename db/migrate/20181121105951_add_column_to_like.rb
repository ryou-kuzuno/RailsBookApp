class AddColumnToLike < ActiveRecord::Migration[5.2]
  def up
    add_column :likes, :impression_id , :integer
  end

  def down
    remove_column :likes, :impression_id, :integer
  end
end
