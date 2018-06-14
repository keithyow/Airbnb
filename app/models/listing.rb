class Listing < ApplicationRecord
	belongs_to :user
	
	mount_uploaders :images, ImagesUploader

	has_many :reservations, dependent: :destroy

end
