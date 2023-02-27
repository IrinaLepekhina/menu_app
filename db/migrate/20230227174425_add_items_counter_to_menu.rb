class AddItemsCounterToMenu < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :items_counter, :integer, default: 0
  end
end
