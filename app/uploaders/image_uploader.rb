# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #ActionController::Base.helpers.asset_path([version_name,"unkown_zavdgs.jpg"].compact.join('_'))
    #
    #"/images/" + [version_name, "default.png"].compact.join('_')
    #"/images/unkown_zavdgs.jpg"
    #'http://res.cloudinary.com/helpperi/image/upload/v1464593337/unkown_zavdgs.jpg'
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  process :tags => ["helpperi"]
  process :convert => "jpg"
  process :resize_to_fit => [1000, 1000]
  cloudinary_transformation :quality => 80

  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :list do
    #process :resize_to_fit => [100, 100]
    process :resize_to_fill => [80, 100]
  end

  version :display do
    process :resize_to_fit => [300, 300]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end