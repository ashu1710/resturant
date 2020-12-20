class ColorsController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@colors = Color.all
	end

	def new
		@color = Color.new
	end

	def create
		@color = Color.new(color_params)
		@color.save
	end

	def destroy
		@isdeleted = false
		@color = Color.find_by id: params[:id]
		if @color.destroy
			@isdeleted = true
		end
	end

	private
	def color_params
		params.require(:color).permit(:color_code)
	end

end
