class CreateBookstores < ActiveRecord::Migration[5.2]
  def change
    create_table :bookstores do |t|
      t.string :title
      t.binary :thumbnail
      t.string :author
      t.text :story
      t.text :impressions

      t.timestamps
    end
  end
end
