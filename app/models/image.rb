class Image < ApplicationRecord
  belongs_to :product
    # validates :image_url, presence: true
  mount_uploader :image, ImageUploader
end
