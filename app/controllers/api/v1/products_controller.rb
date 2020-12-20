class Api::V1::ProductsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token
  skip_before_action :check_authenticate_user, only: [:product_list, :product_details]
  def index
		product_list = current_user.products
 		product_serializer = ProductSerializer.new(product_list)
    render json: {
          status: HTTP_OK[:code],
          data: product_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end

  def create
    if current_user.class.name.eql?('Admin')
      if params[:images].present?
        product = Product.new(product_params)
        product.color_ids = params[:color_ids].split(",")
        product.size_ids = params[:size_ids].split(",")
        if product.save
          product_serializer = ProductSerializer.new(product)
          render json: {
            status: HTTP_OK[:code],
            data: product_serializer.serializable_hash[:data][:attributes]
          }
        else
          error_response_with_obj(HTTP_BAD_REQUEST[:code], "Product not saved.")
        end
      else
        error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing.")
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Only Admin can add product.")
    end
  end


  def update
    if current_user.class.name.eql?('Admin')
      if params[:id].present? && params[:images].present?
        product = Product.find_by id: params[:id]
        if product.present?
          product.color_ids = params[:color_ids].split(",")
          product.size_ids = params[:size_ids].split(",")
          if product.update(product_params)
            product_serializer = ProductSerializer.new(product)
            render json: {
              status: HTTP_OK[:code],
              data: product_serializer.serializable_hash[:data][:attributes]
            }
          else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "Product not updated.")
          end
        else
          error_response_with_obj(HTTP_BAD_REQUEST[:code], "Product not found")
        end
      else
        error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing.")
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Only Admin can add product.")
    end
  end

  def destroy
  	if params[:id].present?
  		@product = Product.find_by(id: params[:id])
  		if @product.present?
  			@product.destroy
  			success_response_without_obj("Product deleted successfully.")
  		else
  			error_response_with_obj(HTTP_BAD_REQUEST[:code], "Product not found")
  		end
  	else
  		error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
  	end
  end

  def product_list
    if params[:category_id].present? || params[:sub_category_id].present?
      if params[:sub_category_id].present?
        product_list = Product.where(sub_category_id: params[:sub_category_id])
      else
        product_list = Product.where(category_id: params[:category_id])
      end
      product_serializer = ProductSerializer.new(product_list)
      render json: {
          status: HTTP_OK[:code],
          data: product_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
      }
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def product_details
    if params[:product_id].present?
      product = Product.find_by id: params[:product_id]
      if product.present?
        product_serializer = ProductDetailSerializer.new(product)
        render json: {
          status: HTTP_OK[:code],
          data: product_serializer.serializable_hash[:data][:attributes]
        }
      else
        error_response_with_obj(HTTP_BAD_REQUEST[:code], "Product not found")
      end
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  private

  def product_params
    params[:is_first_product] = (current_user.products.count == 0 && !current_user.is_admin?) ? true : false
    params[:admin_id] = current_user.id
    params[:sub_category_id] = (params[:sub_category_id].present? && params[:sub_category_id] == '0') ? '' : params[:sub_category_id]
    params.permit(:name,:price, :description, :admin_id, :is_first_product, :category_id, :sub_category_id, images: [])
  end

end
