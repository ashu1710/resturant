class Admins::SubCategoriesController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		@sub_categories = SubCategory.order(id: :desc)
	end

	def new
		@categories =  Category.all.map{ |a| [a.name, a.id] if a.category_type == "buying" }.compact
		@sub_category = SubCategory.new
	end

	def create
		@issaved = false
		@find_category = SubCategory.find_by category_id: params[:sub_category][:category_id], name: params[:sub_category][:name]
		unless @find_category.present?
			@sub_category = SubCategory.new(sub_category_params)
			if @sub_category.save
				@issaved = true
			end
		end
	end

	def edit
		@categories =  Category.all.map{ |a| [a.name, a.id] if a.category_type == "buying" }.compact
		@sub_category = SubCategory.find_by id: params[:id]
	end

	def update
		@is_updated = false
		@find_category = SubCategory.find_by category_id: params[:sub_category][:category_id], name: params[:sub_category][:name]
		unless @find_category.present?
			@sub_category = SubCategory.find_by id: params[:id]
			if @sub_category.update(sub_category_params)
				@is_updated = true
			end
		end
	end

	def destroy
		@isdeleted = false
		@sub_category = SubCategory.find_by id: params[:id]
		if @sub_category.destroy
			@isdeleted = true
		end
	end

	private

	def sub_category_params
 		params.require(:sub_category).permit(:name, :category_id, :sub_category_image)
 	end
end
