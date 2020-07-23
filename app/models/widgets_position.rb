class WidgetsPosition < ActiveRecord::Base
  has_many :widgets, foreign_key: :position_id
end
