class BannersController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@banners = Banner.all
	end

	def new
		@banner = Banner.new
	end

	def create
		@banner = Banner.new(banner_params)
		@banner.save
	end

	def destroy
		@isdeleted = false
		@banner = Banner.find_by id: params[:id]
		if @banner.destroy
			@isdeleted = true
		end
	end

	private
	def banner_params
		params.require(:banner).permit(:banner_image, :product_link_redirect)
	end

end
