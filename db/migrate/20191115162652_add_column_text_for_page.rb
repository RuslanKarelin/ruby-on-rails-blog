class AddColumnTextForPage < ActiveRecord::Migration
  def change
    add_column :pages, :text, :text
  end
end
