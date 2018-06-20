class ListingsController < ApplicationController
	before_action :require_permission, only: [:update, :edit, :destroy]
	before_action :require_host, only: [:create, :new]
	before_action :require_moderator, only:[:verify_page, :verified]


	def index
		@listings = Listing.order(:id).page(params[:page]).where(verify: true)
	end

	def show
		@current = Listing.find(params[:id])
	end

	def new
		@user = current_user
		@listing = Listing.new
		
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to listings_path
		else
			render "new"
		end
	end

	def edit

		@listing = Listing.find(params[:id])
	end

	def update
		@listing  = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to listings_path
		else
			render "edit"
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		if @listing.destroy
			redirect_to listings_path
		end
	end

	def verify_page
		@listings = Listing.order(:id).page(params[:page]).where(verify: false)
	end

	def verified
		@current = Listing.find(params[:id])
		if @current.update(verify: true)
			redirect_to listings_path
		end
	end


	private

	def require_permission
		if Listing.find(params[:id]).user != current_user && !current_user.admin?
			redirect_to listing_path(params[:id])
		end
	end

	def require_host
		if current_user != nil
			if !current_user.host? && !current_user.admin?
				flash[:notice] = "Sorry you do not have permission to perform this task"
				redirect_to listings_path
			end
		else
			redirect_to listings_path, notice: "You do not have the permissions to view that page"
		end
	end

	def listing_params
		params.require(:listing).permit(:name, :description, :address, :price, {images: []})
	end

	def require_moderator
		if current_user != nil
			if !current_user.moderator? && !current_user.admin?
				flash[:notice] = "Sorry you do not have permission to perform this task"
				redirect_to listings_path, notice: "Not allowed"
			end
		else
			redirect_to listings_path, notice: "You do not have the permissions to view that page"
		end
	end




end
