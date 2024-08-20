class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
