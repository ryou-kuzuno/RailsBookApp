class AddIdColumu < ActiveRecord::Migration[5.2]
  def up
    add_column :bookstores, :user_id , :integer
  end

  def down
    remove_column :bookstores, :user_id, :integer
  end
end
