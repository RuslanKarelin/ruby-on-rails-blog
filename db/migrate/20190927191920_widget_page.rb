class WidgetPage < ActiveRecord::Migration
  def change
    create_table :widget_pages do |t|
      t.references :widgetable, polymorphic: true
      t.references :widget, index: true
      t.integer :sort, default: 500
      t.timestamps
    end
  end
end