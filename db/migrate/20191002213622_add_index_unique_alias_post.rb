class AddIndexUniqueAliasPost < ActiveRecord::Migration
  def change
    add_index :posts, :alias, unique: true
  end
end
