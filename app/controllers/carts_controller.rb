class CartsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]

	def add_cart
		if current_user.present?
			@product = Product.find_by id: params[:id]
			params[:color_id].split(",").each do |color|
				params[:size_id].split(",").each do |size|
					@cart = Cart.find_by(product_id: @product.id, user_id: current_user.id, color_id: color, size_id: size)
					if @cart.present?
						qtycart = @cart.qty + 1
						@cart.update(qty: qtycart)
					else
						@cart = Cart.new
						@cart.qty = 1
						@cart.user_id = current_user.id
						@cart.product_id = @product.id
						@cart.color_id = color
						@cart.size_id = size
						@cart.save
					end
				end
			end
		end
	end

	def index
		@carts = current_user.carts
		@carts_total = @carts.map{ |cart| cart.product.price * cart.qty }.sum
	end

	def destroy
		@cart = Cart.find_by id: params[:id]
		@cart.destroy
	end

end
