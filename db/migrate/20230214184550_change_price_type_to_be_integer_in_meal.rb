class ChangePriceTypeToBeIntegerInMeal < ActiveRecord::Migration[7.0]
  def change
    change_column :meals, :price_type, :integer
  end
end
