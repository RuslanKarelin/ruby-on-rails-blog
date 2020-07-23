class CreateWidgetsPositions < ActiveRecord::Migration
  def change
    create_table :widgets_positions do |t|
      t.string :name
      t.timestamps null: false
    end

    positions = %w[
      header1
      header2
      header3
      header4
      header5
      header6
      sidebar
      bottom1
      bottom2
      bottom3
      bottom4
      footer1
      footer2
      footer3
      footer4
      footer5
      footer6
    ]

    positions.each do |position|
      WidgetsPosition.create({name: position})
    end
  end
end
