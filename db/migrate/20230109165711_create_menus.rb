class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :title, comment: 'menu title'
      t.date :date

      t.timestamps
    end
    add_index :menus, :title, unique: true
  end
end
