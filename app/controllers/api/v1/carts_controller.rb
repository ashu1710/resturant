class Api::V1::CartsController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  skip_before_action :check_authenticate_user, only: [:list_sizes, :list_colors]

  def index
    list_cart = current_user.carts
    cart_serializer = CartSerializer.new(list_cart)
    render json: {
          status: HTTP_OK[:code],
          data: cart_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end

  def destroy
  	cart  = Cart.find_by id: params[:id]
  	if cart.present? && cart.destroy
			success_response_without_obj("Product removed from cart successfully.")
  	else
  		error_response_with_obj(HTTP_BAD_REQUEST[:code], "Cart not present.")
  	end
  end

  def create
  	if params[:product_id].present? && params[:color_id].present? && params[:size_id].present?
      cart_new = current_user.carts.where(product_id: params[:product_id], color_id: params[:color_id], size_id: params[:size_id])
      if cart_new.present?
        qty_cart = cart_new.last.qty.present? ? (cart_new.last.qty + 1) : 1
        cart_new.last.update(qty: qty_cart)
        cart_serializer = CartSerializer.new(cart_new)
        render json: {
          status: HTTP_OK[:code],
          data: cart_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
      else
        cart_new = current_user.carts.new(product_id: params[:product_id], color_id: params[:color_id], size_id: params[:size_id])
        if cart_new.save
          cart_serializer = CartSerializer.new([cart_new])
          render json: {
            status: HTTP_OK[:code],
            data: cart_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
          }
        else
          error_response_with_obj(HTTP_BAD_REQUEST[:code], "Cart not saved.")
        end
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def list_colors
  	list_color = Color.all
    color_serializer = ColorSerializer.new(list_color)
    render json: {
          status: HTTP_OK[:code],
          data: color_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end

  def list_sizes
  	list_size = Size.all
    size_serializer = SizeSerializer.new(list_size)
    render json: {
          status: HTTP_OK[:code],
          data: size_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end
end
