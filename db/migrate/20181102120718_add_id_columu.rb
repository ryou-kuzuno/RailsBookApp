class AddIdColumu < ActiveRecord::Migration[5.2]
  def up
    # indexの貼り方
    # add_index table名, カラム名
    # add_index table名, [カラム名, カラム名], :name => '複合index名'
    add_column :bookstores, :user_id , :integer
    # add_index :impressions, [:user_id, :book_id], :name => 'user_book_id', :unique => true
    # add_index :impressions, :user_id
    # add_index :impressions, :book_id
  end

  def down
    remove_column :bookstores, :user_id, :integer
    # remove_index :impressions, :name => 'user_book_id'
    # remove_index :impressions, :user_id
    # remove_index :impressions, :book_id
  end

  
    # indexの貼り方
    # add_index table名, カラム名
    # add_index table名, [カラム名, カラム名], :name => '複合index名'
    
end
