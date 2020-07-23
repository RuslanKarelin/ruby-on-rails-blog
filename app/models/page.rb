class Page < ActiveRecord::Base
  include ModelShare

  validates :name, :alias, presence: true
  validates :alias, uniqueness: true

  has_one :image, as: :imageable, dependent: :destroy
  has_many :widget_pages, as: :widgetable, dependent: :destroy

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: proc {|attributes| attributes[:name].nil?}
end
