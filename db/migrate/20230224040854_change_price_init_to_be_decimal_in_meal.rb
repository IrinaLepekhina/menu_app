class ChangePriceInitToBeDecimalInMeal < ActiveRecord::Migration[7.0]
  def change
    change_column :meals, :price_init, :decimal, precision: 10, scale: 3
  end
end
