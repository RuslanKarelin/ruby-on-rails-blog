class Admin::WidgetableController < Admin::AdminController
  after_action :set_widgets, only: [:update]

  private

  def set_widgets
    @widget_ids = [] unless @widget_ids
    if params[:widget_pages].present? && !@widget_ids.sort!.eql?(params[:widget_pages][:widget_ids].sort!)
      @model.widget_pages.delete_all
      params[:widget_pages][:widget_ids].each do |widget_id|
        @model.widget_pages.create widget_id: widget_id, sort: params[:widget_positions][widget_id]
      end
    end
  end
end