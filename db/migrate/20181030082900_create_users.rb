class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nicename
      t.varchar :password
      t.varchar :mail
      
      t.timestamps
    end
  end
end
