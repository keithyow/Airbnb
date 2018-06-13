class Listing < ApplicationRecord
	belongs_to :user
	
	mount_uploaders :images, ImagesUploader

end
