
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  default_url_options :host => "shaadiwaale.in"
  devise_for :users, :controllers => { passwords: 'users/passwords' }
  	namespace :api do
  		namespace :v1 do
  			namespace :users do
 	 			resources :sessions, only: [:create]
 	 			delete 'sessions/logout', to: "sessions#logout"
 	 			get 'sessions/vendor_city_area_name', to: "sessions#vendor_city_area_name"
 	 			post 'sessions/user_registration', to: "sessions#user_registration"
 	 			post 'sessions/user_devise_token', to: "sessions#user_devise_token"
 	 			post 'sessions/get_area', to: "sessions#get_area"
 	 			post 'sessions/forget_password', to: "sessions#forget_password"
 	 			get 'sessions/user_filter', to: "sessions#user_filter"
 	 		end
 	 		resources :users, only: [:create, :destroy]
 	 		get 'products/product_list', to: 'products#product_list'
 	 		get 'products/product_details', to: 'products#product_details'
 	 		resources :products
 	 		get '/carts/add_to_cart', to: 'carts#add_to_cart'
 	 		resources :carts, only: [:destroy, :index, :create]
			get '/list_colors', to: 'carts#list_colors'
			get '/list_sizes', to: 'carts#list_sizes'
 	 		get 'home/category_list', to: 'home#category_list'
 	 		post 'home/contact_us', to: 'home#contact_us'
 	 		get 'home/sub_category', to: 'home#sub_category'
 	 		get 'home/list_banner', to: 'home#list_banner'
 	 		get '/user_booking', to: 'vendors#user_booking'
 	 		get '/user_order', to: 'vendors#user_order'
 	 		get '/order_booking', to: 'vendors#order_booking'
 	 		get 'vendors/booking_list', to: 'vendors#booking_list'
 	 		get 'vendors/order_list', to: 'vendors#order_list'
 	 		get 'vendors/order_action', to: 'vendors#order_action'
 	 		get 'vendors/booking_action', to: 'vendors#booking_action'
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	# resources :carts, only: [:index, :destroy]
 #  	get 'carts/:id/add_cart', to: 'carts#add_cart', as: 'add_cart'
	get 'profile', to: 'admins/dashboard#profile', as: 'profile'
	# resources :users
	# get '/my_account', to: 'users#my_account', as: 'my_account'
	# get '/about_us', to: 'users#about_us', as: 'about_us'
	# get '/contact_us', to: 'feedbacks#contact_us', as: 'contact_us'

	# get 'products/get_sub_category', to: 'products#get_sub_category'
	# get 'products/remove_attachments', to: 'products#remove_attachments'
	# resources :products
	
	# get 'bookings/:id/accept_booking', to: 'bookings#accept_booking', as: 'accepts_booking'
	# get 'bookings/:id/reject_booking', to: 'bookings#reject_booking', as: 'rejects_booking'
	# resources :bookings

	# get 'orders/:id/accept_order', to: 'orders#accept_order', as: 'accepts_order'
	# get 'orders/:id/reject_order', to: 'orders#reject_order', as: 'rejects_order'
	# get '/order_success', to: 'orders#order_success', as: :order_success
	# resources :orders
	# resources :banners
	# get 'addresses/:id/user_address', to: 'addresses#user_address', as: :user_address
	# resources :addresses

	# get 'feedbacks/:id/show_feedback', to: 'feedbacks#show_feedback', as: 'show_feedback'
	# get '/address_details', to: 'feedbacks#address_details', as: 'address_details'
	# resources :feedbacks
	# resources :notifications
	# namespace :admins do
	#   resources :categories, :sub_categories
	# end
	# get 'vendors/get_area', to: 'vendors#get_area'
	# get 'vendors/set_seq_no', to: 'vendors#set_seq_no'
	# get 'products/:id/first_product', to: 'products#first_product', as: 'first_product'
	# get 'products/:id/sub_category_list', to: 'products#sub_category_list', as: 'sub_category_list'
	# get 'products/:id/product_list', to: 'products#product_list', as: 'product_list'
	# get '/product_filter', to: 'users#product_filter'
	# get '/product_search', to: 'users#product_search'
	# get '/product_sub_filter', to: 'users#product_sub_filter'
	# get 'products/:id/sub_category_product_list', to: 'products#sub_category_product_list', as: 'sub_category_product_list'
	# get 'products/:id/product_details', to: 'products#product_details', as: 'product_details'
	# resources :vendors
	# resources :cities
	# resources :areas
	# resources :colors
	# resources :sizes
	devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }
	patch 'admins/dashboard/update_profile', to: 'admins/dashboard#update_profile'
	patch 'admins/dashboard/change_password', to: 'admins/dashboard#change_password'
	get 'admins/dashboard/index', to: 'admins/dashboard#index'
	get 'admins/other_management', to: 'admins/dashboard#other_management'

	get '/private_policy', to: 'addresses#private_policy'
	get '/terms_conditions', to: 'addresses#terms_conditions'
	root 'admins/dashboard#index'
end