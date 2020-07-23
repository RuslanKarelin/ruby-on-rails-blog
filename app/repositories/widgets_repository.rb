class WidgetsRepository
  def self.get_widgets_for_content(position_name, model)
    if model.present?
      widget_pages = model.try(:widget_pages)
      if widget_pages
        ids = widget_pages.order(:sort).pluck(:widget_id)
        widgets = Widget.joins(:position)
                      .where('"widgets_positions"."name" = \'' + position_name + '\'')
                      .where(id: [ids])
        ids.collect {|id| widgets.detect {|x| x.id == id}}
      end
    end
  end
end