class Admins::TransactionsController < ApplicationController
	before_action :authenticate_admin!
	layout "application"
	def index
	end
end
