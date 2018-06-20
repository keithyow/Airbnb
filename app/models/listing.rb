class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservation, dependent: :destroy
	mount_uploaders :images, ImagesUploader

end
