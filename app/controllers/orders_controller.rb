class OrdersController < ApplicationController
	before_action :authenticate_admin!, except: [:order_success]
	before_action :authenticate_user!, only: [:order_success]
	layout "application", only: [:order_success]
	layout "admin", except: [:order_success]
	def index
		if current_admin.is_admin?
			@list_orders = Order.order(id: :desc)
		else
			@list_orders = Order.all.map { |order| order if order.product.admin_id == current_admin.id  }.uniq.compact.reverse
		end
	end

	def destroy
		@isdeleted = false
		@order = Order.find_by id: params[:id]
		if @order.destroy
			@isdeleted = true
		end
	end

	def order_success
		@booking = current_user.booking.last
		OrderMailer.with(order: @booking).new_order_email_vendor.deliver_now
		OrderMailer.with(order: @booking).new_order_email_user.deliver_now
	end

	def accept_order
		@isdone = false
		@order = Order.find_by id: params[:id]
		if @order.present? &&  @order.update(is_confirmed: true)
			@isdone = true
		end
	end

	def reject_order
		@isdone = false
		@order = Order.find_by id: params[:id]
		if @order.present? &&  @order.update(is_confirmed: false)
			@isdone = true
		end
	end
end
