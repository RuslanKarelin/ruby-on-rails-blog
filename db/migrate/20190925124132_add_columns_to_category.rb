class AddColumnsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :title, :string
    add_column :categories, :description, :string
    add_column :categories, :h1, :string
    add_column :categories, :breadcrumb, :string
    add_column :categories, :intro_text, :text
  end
end