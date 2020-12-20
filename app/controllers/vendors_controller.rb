class VendorsController < ApplicationController
	before_action :authenticate_admin!, except: [:get_area]
	layout "admin"
	def index
		@vendors_list = Admin.where(is_admin: false).order(id: :desc)
	end

	def new
		@cities = City.pluck(:name, :id)
		@cities = @cities.unshift(["Select City", ""])
		@vendor = Admin.new
	end

	def create
		@issaved = false
		@vendor = Admin.new(vendor_params)
		if @vendor.save
			@issaved = true
		end
	end

	def set_seq_no
		if params[:seq_no].present?
			admin  = Admin.find_by seq_no: params[:seq_no]
			current_vendor = Admin.find_by(id: params[:vendor_id].split(" ").first)
			current_vendor_seq_no = current_vendor.seq_no
			current_vendor.update(seq_no: params[:seq_no])
			if admin.present?
				admin.update seq_no: current_vendor_seq_no
			end
		else
			if params[:vendor_id].present?
				Admin.find_by(id: params[:vendor_id].split(" ").first).update(seq_no: nil)
			end
		end
		render :js => "window.location = '/vendors/'"
	end

	def approved_vendor
		@vendor = Admin.find_by id: params[:id]
		if @vendor.present?
			@vendor.update(is_approved: true)
		end
		respond_to do |format|
		  format.js {}
		end
	end

	def get_area
		@areas = Area.where city_id: params["id"]
		respond_to do |format|
		  format.js {}
		end
	end

	def edit
		@cities = City.pluck(:name, :id)
		@vendor = Admin.find_by id: params[:id]
		@area = Area.where(city_id: @vendor.city_id).pluck(:name, :id)
	end

	def update
		@is_updated = false
		@vendor = Admin.find_by id: params[:id]
		if @vendor.update(vendor_params)
			@is_updated = true
		end
	end

	def destroy
		@isdeleted = false
		@vendor = Admin.find_by id: params[:id]
		if @vendor.destroy
			@isdeleted = true
		end
	end

	private

	def vendor_params
		params[:admin].delete(:password) unless params[:admin][:password].present?
 		params.require(:admin).permit(:email, :mobile, :address, :city_id, :area_id,:password)
 	end
end
