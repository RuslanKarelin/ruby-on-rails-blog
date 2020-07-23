class AddIndexUniqueAliasPage < ActiveRecord::Migration
  def change
    add_index :pages, :alias, unique: true
  end
end
