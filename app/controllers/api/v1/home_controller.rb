class Api::V1::HomeController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  skip_before_action :check_authenticate_user

  def category_list
    list_category = Category.all
    category_serializer = CategorySerializer.new(list_category)
    render json: {
          status: HTTP_OK[:code],
          data: category_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end

  def sub_category
    if params[:category_id].present?
      @subcategory = SubCategory.where(category_id: params[:category_id])
      subcategory_serializer = SubCategorySerializer.new(@subcategory)
      render json: {
          status: HTTP_OK[:code],
          data: subcategory_serializer.serializable_hash[:data].map{ |data| data[:attributes] }
        }
    else
      error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params missing")
    end
  end

  def list_banner
  	list_category = Banner.all
    banner_serializer = BannerSerializer.new(list_category)
    render json: {
          status: HTTP_OK[:code],
          data: banner_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
  end

  def contact_us
    feedback = Feedback.new(feedback_params)
    feedback.save
    render json: {
          status: HTTP_OK[:code],
          message: 'We will contact you as soon as possible'
      }
  end

  private

  def feedback_params
    params.require(:feedback).permit(:first_name, :last_name, :email, :mobile, :msg)
  end

end
