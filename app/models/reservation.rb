class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validate :check_overlap
	validates :check_start, presence: true
	validates :check_end, presence: true

	def check_overlap
		dates = []
		listing.reservation.each {|x| dates += (x.start...x.end).to_a}
		if (dates && (self.start...self.end).to_a).count != 0
			errors.add(:overlapping_dates, "The dates overlap! Reservation cannot be made on dates that overlap")
		end
	end

	def check_start
		if self.start < Date.today
			errors.add(:invalid_date, "You cannot check in on that date")
		end
	end

	def check_end
		if self.end < self.start
			errors.add(:invalid_date, "Check out cannot be before check in")
		end
	end
end
