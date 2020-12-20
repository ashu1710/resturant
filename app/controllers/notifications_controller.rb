class NotificationsController < ApplicationController
	before_action :authenticate_admin!
	layout "admin"
	require 'fcm'
	def index
		@notifications = Notification.order(id: :desc)
	end

	def new
		@notification = Notification.new
	end

	def create
		@issaved = false
		@notification = Notification.new(notification_params)
		if @notification.save
			@issaved = true
		end
		fcm_client = FCM.new(ENV['fcm_key']) # set your FCM_SERVER_KEY
	    options = { priority: 'high',
	                data: { notification: { message: params[:notification][:msg], icon: '' } },
	                notification: {
	                body: params[:notification][:msg],
	                sound: 'default',
	                icon: ''
	                }
	              }
	    DeviseToken.pluck(:token).uniq.each_slice(20) do |registration_id|
	        response = fcm_client.send(registration_id, options)
	    end
	end

	def edit
		@notification = Notification.find_by id: params[:id]
	end

	def update
		@is_updated = false
		@notification = Notification.find_by id: params[:id]
		if @notification.update(notification_params)
			@is_updated = true
		end
	end

	def destroy
		@isdeleted = false
		@notification = Notification.find_by id: params[:id]
		if @notification.destroy
			@isdeleted = true
		end
	end

	private

	def notification_params
 		params.require(:notification).permit(:msg)
 	end
end
