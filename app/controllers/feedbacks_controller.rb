class FeedbacksController < ApplicationController
	before_action :authenticate_admin!, except: [:contact_us, :create]
	layout "admin", except: [:contact_us, :create]
	require 'fcm'
	def index
		@feedbacks = Feedback.order(id: :desc)
	end

	def contact_us
		@feedback = Feedback.new
	end

	def address_details
		@addresses = Address.order(id: :desc)
	end

	def create
		@feedback = Feedback.new(feedback_params)
		@feedback.save
	end

	def show_feedback
		@isdone = false
		@feedback = Feedback.find_by id: params[:id]
		if @feedback.present? &&  @feedback.update(is_confirmed: true)
			@isdone = true
		end
	end


	private

	def feedback_params
		params.require(:feedback).permit(:first_name, :last_name, :email, :mobile, :msg)
	end
end
