class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :postal_code,      null: false
      t.string :prefectures,      null: false
      t.string :city,             null: false
      t.string :adderess,         null: false
      t.string :building_name
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
