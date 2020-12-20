class BookingsController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :destroy, :accept_booking, :reject_booking]
	before_action :authenticate_user!, only: [:create]
	layout "application" , only: [:create]
	layout "admin" , only: [:index, :destroy, :accept_booking, :reject_booking]
	def index
		if current_admin.is_admin?
			@list_bookings = Booking.order(id: :desc)
		else
			@list_bookings = Booking.all.map { |book| book if book.product.admin_id == current_admin.id  }.uniq.compact.reverse
		end
	end

	def create
		@booking = Booking.new(booking_params)
		@booking.save
		redirect_to order_success_path
	end

	def destroy
		@isdeleted = false
		@booking = Booking.find_by id: params[:id]
		if @booking.destroy
			@isdeleted = true
		end
	end

	def accept_booking
		@isdone = false
		@booking = Booking.find_by id: params[:id]
		if @booking.present? &&  @booking.update(is_confirmed: true)
			@isdone = true
		end
	end

	def reject_booking
		@isdone = false
		@booking = Booking.find_by id: params[:id]
		if @booking.present? &&  @booking.update(is_confirmed: false)
			@isdone = true
		end
	end


	private

	def booking_params
		params.require(:booking).permit(:user_id, :product_id, :time_to, :time_from, :booking_date)
	end

end
