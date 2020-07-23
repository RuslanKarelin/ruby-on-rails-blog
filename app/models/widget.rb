class Widget < ActiveRecord::Base
  validates :name, :wname, presence: true
  belongs_to :position, class_name: 'WidgetsPosition'
  has_many :widget_pages, dependent: :destroy
end
