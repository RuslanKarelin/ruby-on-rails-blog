class AddColumnsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :description, :string
    add_column :posts, :h1, :string
    add_column :posts, :breadcrumb, :string
    add_column :posts, :intro_text, :text
  end
end
