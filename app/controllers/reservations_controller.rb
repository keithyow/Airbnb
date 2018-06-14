class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@reservation = current_user.reservation.new(reservation_params)
		if @reservation.save
			redirect_to listing_reservation_path
		else
			render 'new'
		end
	end

	private

	def reservation_params
		params.require(:reservation).permit(:check_in, :check_out, :number_of_guest)
	end
end