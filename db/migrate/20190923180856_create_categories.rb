class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :alias
      t.text :top_text
      t.text :bottom_text
      t.references :category, index: true
      t.timestamps null: false
    end
  end
end
