class Api::V1::Users::SessionsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token
  skip_before_action :check_authenticate_user, only: [:get_area, :create, :vendor_city_area_name, :user_registration, :forget_password, :user_filter]

  def create
    if params['user'].present? && params['user']['email'].present?
      if(params['user']['is_vendor'].eql?('true'))
      	user = Admin.find_by_email(params['user']['email'])
        utype = 'Admin'
      else
      	user = User.find_by_email(params['user']['email'])
        utype = 'User'
      end
      if user && user.valid_password?(params['user']['password'])
        @auth_token = AuthToken.create(user_id: user.id, user_type: utype,token: SecureRandom.hex(12))
        session_serializer = SessionSerializer.new(@auth_token)
        render json: {
          status: HTTP_OK[:code],
          message: "Login Successfully",
          data: session_serializer.serializable_hash[:data][:attributes]
        }
      else
        error_response_with_obj(HTTP_NOT_FOUND[:code], "Email and password does not match")
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def user_devise_token
    if params[:devise_token].present?
      DeviseToken.create(user_id: current_user.id, token: params[:devise_token])
      render json: {
          status: HTTP_OK[:code],
          message: "Created Successfully"
      }
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def forget_password
    admin = Admin.find_by(email: params['user']['email'])
    user = User.find_by(email: params['user']['email'])
    if user.present? || admin.present?
     user.present? ? user.send_reset_password_instructions : admin.send_reset_password_instructions
     render json: {
        status: HTTP_OK[:code],
        message: "Check your mail for reset your password",
      }
    else
     render json: {
        status: HTTP_OK[:code],
        message: "User not found.",
      }
    end
  end

  def user_filter
    if params[:color_ids].present? || params[:size_ids].present? || params[:sub_category_id].present?
      all_products = []
      if params[:size_ids].present? && params[:color_ids].present?
        sizes = Size.where(id: params[:size_ids].split(","))
        product_size = []
        sizes.each do |size|
          product_size << size.products.where(sub_category_id: params[:sub_category_id])
        end
        product_size.flatten.each do |product|
          params[:color_ids].split(",").map(&:to_i).each do |color|
            all_products << product if product.color_ids.include?(color)
          end
        end
        all_products.flatten!
      else
        if params[:size_ids].present?
          sizes = Size.where(id: params[:size_ids].split(","))
          sizes.each do |size|
            all_products << size.products.where(sub_category_id: params[:sub_category_id])
          end
          all_products.flatten!
        end
        if params[:color_ids].present?
          colors = Color.where(id: params[:color_ids].split(","))
          colors.each do |color|
            all_products << color.products.where(sub_category_id: params[:sub_category_id])
          end
          all_products.flatten!
        end
        if !params[:color_ids].present? && !params[:size_ids].present?
          all_products = Product.where(sub_category_id: params[:sub_category_id])
        end
      end
      product_serializer = ProductSerializer.new(all_products.uniq)
      render json: {
          status: HTTP_OK[:code],
          data: product_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
      }
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def vendor_city_area_name
    list_city = City.all
    list_area = Area.all
    city_serializer = CitySerializer.new(list_city)
    area_serializer = AreaSerializer.new(list_area)
    data_hash = { :area => {}, :city => {} }
    data_hash[:city] = city_serializer.serializable_hash[:data].map{ |data| data[:attributes]}.unshift({ id: 5000000, city_name: 'All' })
    data_hash[:area] = area_serializer.serializable_hash[:data].map{ |data| data[:attributes]}.unshift({ id: 5000000, area_name: 'All', city_id: 5000000, city_name: 'All'  })
    render json: {
        status: HTTP_OK[:code],
        data: data_hash
    }
  end

  def get_area
    if params[:city_id].present?
      @area = Area.where(city_id: params[:city_id])
      area_serializer = AreaSerializer.new(@area)
      render json: {
          status: HTTP_OK[:code],
          data: area_serializer.serializable_hash[:data].map{ |data| data[:attributes] }.unshift({ id: 5000000, area_name: 'All' })
        }
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def logout
    if auth_token.present? && auth_token.destroy
      success_response_without_obj("Logout Successfully")
    else
      success_response_without_obj("Already Logout" )
    end
  end

  def user_registration
    if params['user'].present? && params['user']['email'].present?
      if(params['user']['is_vendor'].eql?('true'))
        user = Admin.find_by_email(params['user']['email'])
        if user.present?
          error_response_with_obj(HTTP_NOT_FOUND[:code], "Email ID Already register with us.")
        else
          user = Admin.new
          user.email = params['user']['email']
          user.mobile = params['user']['mobile']
          user.city_id = params['user']['city_id']
          user.area_id = params['user']['area_id']
          user.password = params['user']['password']
          user.save
          @auth_token = AuthToken.create(user_id: user.id, user_type: 'Admin',token: SecureRandom.hex(12))
          session_serializer = SessionSerializer.new(@auth_token)
          render json: {
              status: HTTP_OK[:code],
              message: "Register Successfully",
              data: session_serializer.serializable_hash[:data][:attributes]
          }
        end        
      else
        user = User.find_by_email(params['user']['email'])
        if user.present?
          error_response_with_obj(HTTP_NOT_FOUND[:code], "Email ID Already register with us.")
        else
          user = User.new(user_params)
          user.save
          @auth_token = AuthToken.create(user_id: user.id, user_type: 'User',token: SecureRandom.hex(12))
          session_serializer = SessionSerializer.new(@auth_token)
            render json: {
              status: HTTP_OK[:code],
              message: "Register Successfully",
              data: session_serializer.serializable_hash[:data][:attributes]
          }
        end
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def user_params
    params.require(:user).permit(:email, :mobile, :password)
  end

end
