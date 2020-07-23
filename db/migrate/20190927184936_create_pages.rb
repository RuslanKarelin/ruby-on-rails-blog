class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :alias
      t.string :title
      t.string :description
      t.string :h1
      t.string :breadcrumb
      t.text :intro_text
      t.timestamps null: false
    end
  end
end
