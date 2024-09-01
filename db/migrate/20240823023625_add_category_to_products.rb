class AddCategoryToProducts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :category, null: false, foreign_key: true, type: :uuid
  end
end
