class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :title, comment: 'meal title'
      t.string :price_type
      t.text :description
      t.boolean :promo
      t.string :cover_image
      t.decimal :price_init, comment: 'initial price'
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :meals, :title, unique: true
  end
end
