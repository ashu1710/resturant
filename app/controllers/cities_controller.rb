class CitiesController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@cities = City.order(id: :desc)
	end

	def new
		@city = City.new
	end

	def create
		@issaved = false
		@find_city = City.find_by name: params[:city][:name]
		unless @find_city.present?
			@city = City.new(city_params)
			if @city.save
				@issaved = true
			end
		end
	end

	def edit
		@city = City.find_by id: params[:id]
	end

	def update
		@is_updated = false
		@find_city = City.find_by name: params[:city][:name]
		@city = City.find_by id: params[:id]
		unless @find_city.present?
			if @city.update(city_params)
				@is_updated = true
			end
		end
	end

	def destroy
		@isdeleted = false
		@city = City.find_by id: params[:id]
		if @city.destroy
			@isdeleted = true
		end
	end

	private

	def city_params
 		params.require(:city).permit(:name)
 	end
end
