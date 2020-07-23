class AddColumnBanForProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :ban, :boolean, default: false
  end
end
