class ReservationsController < ApplicationController
	before_action :require_signin
	before_action :require_permission, except: [:new,:create,:index]

	def index
		@reservations = current_user.reservation.order(:id)
	end

	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new 
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = current_user.reservation.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		if @reservation.save
			redirect_to user_reservations_path
			# redirect_to root_path
		else
			redirect_to new_user_listing_reservation_path, notice: "Invalid date selection! Reservation cannot be made!"
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def show
	end

	private
	
	def reservation_params
		params.require(:reservation).permit(:guest, :start, :end)
	end

	def require_permission
		if Reservation.find(params[:id]).user != current_user && !current_user.admin
			redirect_to listings_path, notice: "You do not have permission to perform this task"
		end
	end

	def require_signin
		if current_user == nil && !current_user.admin
			redirect_to sign_in_path, notice: "You need to sign in to perform this task"
		end
	end
end
