class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :wname
      t.integer :sort, default: 500
      t.references :position, index: true, class_name: 'WidgetsPosition'
      t.timestamps null: false
    end

    widgets = %w[
        social_widget
        category_widget
        newsletter_widget
        post_widget
        galery_widget
        recent_posts_widget
        posts_from_categories_widget
        posts_from_categories_v2_widget
        posts_from_categories_v3_widget
    ]

    widgets.each do |widget|
      Widget.create({name: widget, wname: widget})
    end
  end
end
