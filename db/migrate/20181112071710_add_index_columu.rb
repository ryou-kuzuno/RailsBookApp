class AddIndexColumu < ActiveRecord::Migration[5.2]
  def up
    # indexの貼り方
    # add_index table名, カラム名
    # add_index table名, [カラム名, カラム名], :name => '複合index名'
    add_index :impressions, [:user_id, :bookstore_id], :name => 'user_bookstore_id', :unique => true
    add_index :impressions, :user_id
    add_index :impressions, :bookstore_id
  end

  def down
    remove_index :impressions, :name => 'user_bookstore_id'
    remove_index :impressions, :user_id
    remove_index :impressions, :bookstore_id
  end
end
