class ChangePriceToBeDecimalInMenuMeal < ActiveRecord::Migration[7.0]
  def change
    change_column :menu_meals, :price, :decimal, precision: 10, scale: 3
  end
end
