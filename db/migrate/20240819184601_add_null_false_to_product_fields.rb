class AddNullFalseToProductFields < ActiveRecord::Migration[7.2]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :description, false
    change_column_null :products, :price, false
  end
end
