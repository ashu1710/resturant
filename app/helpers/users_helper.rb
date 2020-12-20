module UsersHelper
	HTTP_OK = {code: 200, message: 'Ok'}
  HTTP_BAD_REQUEST = {code: 400, message: 'Bad Request'}
  HTTP_UNAUTHORIZED = {code: 401, message: 'Invalid Authentication token'}
  HTTP_FORBIDDEN = {code: 403, message: 'Forbidden'}
  HTTP_NOT_FOUND = {code: 404, message: 'Resource Not Found'}
  HTTP_INTERNAL_SERVER_ERROR = {code: 500, message: 'Internal Server Error'}
  HTTP_SERVICE_UNAVAILABLE = {code: 503, message: 'Service Unavailable'}

  def success_response_with_obj(data_attribute)
    unless data_attribute.class.eql?(Array)
      data_attribute = [data_attribute]
    end
    render json: {
      status: HTTP_OK,
      data: data_attribute
    }
  end

  def success_response_without_obj(data_attribute)
    render json: {
      status: HTTP_OK[:code],
      message: data_attribute
    }
  end

  def error_response_without_obj(status)
    render json: {
      status: status
    }
  end

  def error_response_with_obj(status, data_attribute)
    render json: {
        status: status,
        message: data_attribute
    }
  end
end
