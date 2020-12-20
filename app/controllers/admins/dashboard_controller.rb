class Admins::DashboardController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	def index
		if current_admin.is_admin?
			@product_count = Product.count
			@order_count = Order.count
			@booking_count = Booking.count
		else
			@product_count = Product.where(admin_id: current_admin.id).count
			@order_count = Order.all.map { |order| order  if order.product.admin_id == current_admin.id }.compact.uniq.count
			@booking_count = Booking.all.map { |booking| booking  if booking.product.admin_id == current_admin.id }.compact.uniq.count
		end	
	end

	def other_management
	end

	def profile
		@admin = current_admin
		@cities = City.pluck(:name, :id)
		@cities = @cities.unshift(["Select City", ""])
		@area = Area.where(city_id: current_admin.city_id).pluck(:name, :id)
	end
	def update_profile
		if current_admin.present?
			current_admin.update(profile_params)
		end
		redirect_to profile_path, flash: { success: "Profile Updated successfully." }
	end

	def change_password
		if params[:admin][:password] == params[:admin][:new_password]
			current_admin.update(password: params[:admin][:new_password])
			sign_in(current_admin, :bypass => true)
			redirect_to profile_path, flash: { success: "Password Updated successfully." }
		else
			redirect_to profile_path, flash: { success: "Password doesn't match. try again" }
		end
	end

	private
	
	def profile_params
		params.require(:admin).permit(:mobile, :avatar, :address, :city_id, :area_id)
	end
end
