class UsersController < ApplicationController
	layout "admin", only: [:new, :index, :destroy]
	before_action :authenticate_admin!, except: [:dashboard, :my_account, :about_us, :contact_us, :contact_us, :product_filter, :product_sub_filter, :product_search]
	before_action :authenticate_user!, except: [:dashboard,:about_us, :contact_us, :index, :contact_us, :product_filter, :product_sub_filter, :product_search, :destroy]

	def new
		@user = User.new
	end

	def index
		@user_list = User.all
	end

	def dashboard
		@categories = Category.all
		@banners = Banner.all
	end

	def product_sub_filter
		@products = []
		if params[:size_id].present?
			sizes = Size.where(id: params[:size_id].split(","))
			sizes.each do |size|
				@products << size.products.where(sub_category_id: params[:sub_category_id])
			end
			@products.flatten!
		else
			@products = Product.where(sub_category_id: params[:sub_category_id])
		end
		if params[:color_id].present?
			color = Color.find_by(id: params[:color_id])
			@products = color.products.where(sub_category_id: params[:sub_category_id])
		end
	end

	def product_filter
		@areas = Area.where(city_id: params[:city_id])
		if params[:category_id].present?
			if params[:city_id].present?
				@products = Product.includes(:admin).where("admins.city_id = ? and products.category_id = ?", params[:city_id], params[:category_id]).references(:admin)
				if params[:sort_type].present?
					if params[:sort_type].eql?('lth')
						@products = @products.order(price: :asc)
					else
						@products = @products.order(price: :desc)
					end
				end
			end
			if params[:area_id].present?
				@products = Product.includes(:admin).where("admins.area_id = ? and products.category_id = ?", params[:area_id], params[:category_id]).references(:admin)
				if params[:sort_type].present?
					if params[:sort_type].eql?('lth')
						@products = @products.order(price: :asc)
					else
						@products = @products.order(price: :desc)
					end
				end
			end
			if !params[:city_id].present? && !params[:area_id].present? && params[:sort_type].present?
				@products = Product.where(category_id: params[:category_id])
				if params[:sort_type].eql?('lth')
					@products = @products.order(price: :asc)
				else
					@products = @products.order(price: :desc)
				end
			end
			if !params[:city_id].present? && !params[:area_id].present? && !params[:sort_type].present?
				@products = Product.where(category_id: params[:category_id])
			end
		else
			if params[:city_id].present?
				@products = Product.includes(:admin).where("admins.city_id = ? and products.sub_category_id = ?", params[:city_id], params[:sub_category_id]).references(:admin)
				if params[:sort_type].present?
					if params[:sort_type].eql?('lth')
						@products = @products.order(price: :asc)
					else
						@products = @products.order(price: :desc)
					end
				end
			end
			if params[:area_id].present?
				@products = Product.includes(:admin).where("admins.area_id = ? and products.sub_category_id = ?", params[:area_id], params[:sub_category_id]).references(:admin)
				if params[:sort_type].present?
					if params[:sort_type].eql?('lth')
						@products = @products.order(price: :asc)
					else
						@products = @products.order(price: :desc)
					end
				end
			end
			if !params[:city_id].present? && !params[:area_id].present? && params[:sort_type].present?
				@products = Product.where(sub_category_id: params[:sub_category_id])
				if params[:sort_type].eql?('lth')
					@products = @products.order(price: :asc)
				else
					@products = @products.order(price: :desc)
				end
			end
			if !params[:city_id].present? && !params[:area_id].present? && !params[:sort_type].present?
				@products = Product.where(sub_category_id: params[:sub_category_id])
			end
		end
	end


	def product_search
		if params[:category_id].present?
			@products = Product.where("category_id = ? AND (lower(name) LIKE ? OR price = ? OR lower(description) LIKE ?)", params[:category_id], "%#{params[:search].downcase}%", params[:search].to_i, "%#{params[:search].downcase}%")
		else
			@products = Product.where("sub_category_id = ? AND (lower(name) LIKE ? OR price = ? OR lower(description) LIKE ?)", params[:sub_category_id], "%#{params[:search].downcase}%", params[:search].to_i, "%#{params[:search].downcase}%")
		end
	end

	def my_account
		@order = current_user.booking
		@product_size_color = current_user.products_orders_sizes_colors
	end

	def destroy
		@isdeleted = false
		@user = User.find_by id: params[:id]
		if @user.destroy
			@isdeleted = true
		end
	end
end
