class CreateMenuMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_meals do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
