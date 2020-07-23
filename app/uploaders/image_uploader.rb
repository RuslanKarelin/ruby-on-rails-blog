class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.imageable_type.underscore}/#{model.id}"
  end

  version :large_thumb do
    process resize_to_fill: [450, 310]
  end

  version :middle_thumb do
    process resize_to_fill: [270, 190]
  end

  version :small_thumb do
    process resize_to_fill: [180, 107]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
