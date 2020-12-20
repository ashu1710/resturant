class AreasController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@areas = Area.order(id: :desc)
	end

	def new
		@cities =  City.pluck(:name, :id)
		@area = Area.new
	end

	def create
		@issaved = false
		@find_area = Area.find_by city_id: params[:area][:city_id], name: params[:area][:name]
		unless @find_area.present?
			@area = Area.new(area_params)
			if @area.save
				@issaved = true
			end
		end
	end

	def edit
		@cities =  City.pluck(:name, :id)
		@area = Area.find_by id: params[:id]
	end

	def update
		@is_updated = false
		@find_area = Area.find_by city_id: params[:area][:city_id], name: params[:area][:name]
		unless @find_area.present?
			@area = Area.find_by id: params[:id]
			if @area.update(area_params)
				@is_updated = true
			end
		end
	end

	def destroy
		@isdeleted = false
		@area = Area.find_by id: params[:id]
		if @area.destroy
			@isdeleted = true
		end
	end

	private

	def area_params
 		params.require(:area).permit(:name, :city_id)
 	end
end
