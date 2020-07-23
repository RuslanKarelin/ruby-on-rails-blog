class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :alias
      t.text :text
      t.references :category, index: true
      t.timestamps null: false
    end
  end
end
