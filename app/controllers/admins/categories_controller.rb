class Admins::CategoriesController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@categories = Category.order(id: :desc)
	end

	def new
		@category = Category.new
	end

	def create
		@issaved = false
		@find_category = Category.find_by name: params[:category][:name]
		unless @find_category.present?
			@category = Category.new(category_params)
			if @category.save
				@issaved = true
			end
		end
	end

	def edit
		@category = Category.find_by id: params[:id]
	end

	def update
		@is_updated = false
		@find_category = Category.find_by name: params[:category][:name]
		@category = Category.find_by id: params[:id]
		unless @find_category.present?
			if @category.update(category_params)
				@is_updated = true
			end
		end
	end

	def destroy
		@isdeleted = false
		@category = Category.find_by id: params[:id]
		if @category.destroy
			@isdeleted = true
		end
	end

	private

	def category_params
 		params.require(:category).permit(:name, :category_type, :category_image)
 	end
end
