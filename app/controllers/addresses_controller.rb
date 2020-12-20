class AddressesController < ApplicationController
	before_action :authenticate_user!, except: [:private_policy, :terms_conditions]

	def create
		@address = current_user.address.create(adddress_params)
		if params[:is_cart].present?
			carts = current_user.carts
			@order_list = []			
			carts.each do |cart|
				@order = current_user.order.new
				@order.order_date = Date.today
				@order.order_receive_date = Date.today + 6.day
				@order.address_id = @address.id
				@order.product_id = cart.product_id
				@order.save
				product_order_size_order =  current_user.products_orders_sizes_colors.new
				product_order_size_order.product_id = @order.product_id
				product_order_size_order.order_id = @order.id
				product_order_size_order.size_id = cart.size_id
				product_order_size_order.color_id = cart.color_id
				product_order_size_order.qty = cart.qty
				product_order_size_order.save
				@order_list << product_order_size_order
				OrderMailer.with(order: @order).new_order_email_vendor.deliver_now
				OrderMailer.with(order: @order).new_order_email_user.deliver_now	
				cart.destroy
			end
		else
			@order = current_user.order.new
			@order.order_date = Date.today
			@order.order_receive_date = Date.today + 6.day
			@order.address_id = @address.id
			@order.product_id = params[:product_id]
			@order.save
			@order_list = []			
			product_order_size_order =  current_user.products_orders_sizes_colors.new
			product_order_size_order.product_id = @order.product_id
			product_order_size_order.order_id = @order.id
			product_order_size_order.size_id = params[:size_ids] 
			product_order_size_order.color_id = params[:color_ids]
			product_order_size_order.save
			@order_list << product_order_size_order
			OrderMailer.with(order: @order).new_order_email_vendor.deliver_now
			OrderMailer.with(order: @order).new_order_email_user.deliver_now
		end
		redirect_to address_path(@order, product_order_size_order_id: @order_list.map(&:id))
	end

	def show
		@order = Order.find_by id: params[:id]
		@order_list = ProductsOrdersSizesColor.where(id: params[:product_order_size_order_id])
	end

	def user_address
		@new_address = Address.new
		@city = City.pluck(:name, :id)
		@area = Area.pluck(:name, :id)
		@product  = Product.find_by(id: params[:id])
	end

	private

	def adddress_params
		params.require(:address).permit(:street_1, :city_name, :area_name)
	end

end
