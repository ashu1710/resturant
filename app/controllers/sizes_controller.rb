class SizesController < ApplicationController
	layout "admin"
	def index
		@sizes = Size.all
	end

	def new
		@size = Size.new
	end

	def create
		@size = Size.new(size_params)
		@size.save
	end

	def destroy
		@isdeleted = false
		@size = Size.find_by id: params[:id]
		if @size.destroy
			@isdeleted = true
		end
	end

	private
	def size_params
		params.require(:size).permit(:size_no)
	end
end
