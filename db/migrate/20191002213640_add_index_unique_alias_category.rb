class AddIndexUniqueAliasCategory < ActiveRecord::Migration
  def change
    add_index :categories, :alias, unique: true
  end
end
