class ProductsController < ApplicationController
	before_action :authenticate_admin!, except: [:product_list, :product_details, :sub_category_list, :sub_category_product_list, :product_filter]
	layout "admin", except: [:product_list, :product_details, :sub_category_list, :sub_category_product_list, :product_filter]
	def index
		if current_admin.is_admin?
			@list_products = Product.order(id: :desc)
		else
			@list_products = Product.where(admin_id: current_admin).order(id: :desc)
		end
	end

	def product_list
		@city = City.pluck(:name, :id)
		@area = Area.pluck(:name, :id)
		@products = Product.where(category_id: params[:id]).sort_by { |a| a.admin.seq_no || 'z' }
	end

	def sub_category_list
		@sub_category = SubCategory.where(category_id: params[:id])
	end

	def sub_category_product_list
		@products = Product.where(sub_category_id: params[:id]).sort_by { |a| a.admin.seq_no || 'z' }
		@city = City.pluck(:name, :id)
		@area = Area.pluck(:name, :id)
	end

	def product_details
		@product = Product.find_by id: params[:id]
		@booking = Booking.new
	end

	def new
		@categories = Category.pluck(:name, :id)
		@categories = @categories.unshift(["Select Category", ""])
		@product =  Product.new
	end

	def show
	end

	def first_product
		@product = Product.find_by id: params[:id]
		if @product.present?
			@product.update(is_first_product: false)
		end
		redirect_to products_path, flash: { success: "Product Updated successfully." }
	end

	def get_sub_category
		@sub_categories = SubCategory.where category_id: params["id"]
		respond_to do |format|
		  format.js {}
		end
	end

	def create
		@issaved = false
		@product = Product.new(product_params)
		if @product.save
			@issaved = true
		end
	end

	def edit
		@categories = Category.pluck(:name, :id)
		@product = Product.find_by id: params[:id]
		@sub_category = SubCategory.where(category_id: @product.category_id).pluck(:name, :id)
	end

	def update
		@is_updated = false
		@product = Product.find_by id: params[:id]
		if @product.update(product_params)
			@is_updated = true
		end
	end

	def remove_attachments
		@product_image = ActiveStorage::Attachment.find(params[:id])
  		@product_image.purge
  		respond_to do |format|
		  format.js {}
		end
	end

	def destroy
		@isdeleted = false
		@product = Product.find_by id: params[:id]
		if @product.destroy
			@isdeleted = true
		end
	end

	private

	def product_params
		params[:product][:is_first_product] = (current_admin.products.count == 0 && !current_admin.is_admin?) ? true : false 
		params[:product][:admin_id] = current_admin.id
 		params.require(:product).permit(:name,:price, :description, :admin_id, :is_first_product, :category_id, :sub_category_id, images: [], size_ids: [], color_ids: [])
 	end
end
