class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: proc {|attributes| attributes[:name].nil?}
end
