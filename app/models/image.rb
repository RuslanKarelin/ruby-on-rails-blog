class Image < ActiveRecord::Base
  attr_accessor :name
  belongs_to :imageable, polymorphic: true, touch: true

  mount_uploader :name, ImageUploader
  delegate :url, :size, :path, to: :image
  alias_attribute :filename, :original_filename
end
