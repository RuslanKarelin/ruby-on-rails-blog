class WidgetPage < ActiveRecord::Base
  belongs_to :widgetable, polymorphic: true
  belongs_to :widget
  scope :for, ->(widget) {where(widget_id: widget.id).first}
end
