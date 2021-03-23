class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,               null: false
      t.string :status,             null: false
      t.string :size
      t.integer :price,              null: false
      t.text :description,           null: false
      t.string :burden,              null: false
      t.string :send_method,         null: false
      t.string :category,            null: false
      # t.string :region,              null: false
      t.string :date,                null: false
      t.datetime :created_at,        null: false
      t.datetime :updated_at,       null: false
      # t.integer :buyer_id,        foreign_key: true
      # t.integer :seler_id,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
