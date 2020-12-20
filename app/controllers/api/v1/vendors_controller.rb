class Api::V1::VendorsController < Api::V1::ApiController
    skip_before_action :verify_authenticity_token

    def booking_list
		list_bookings = Booking.all.map { |book| book if book.product.admin_id == current_user.id  }.uniq.compact.reverse
 		booking_serializer = BookingSerializer.new(list_bookings)
        render json: {
          status: HTTP_OK[:code],
          data: booking_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
    end

    def order_list
        list_order = ProductsOrdersSizesColor.all.map { |book| book if book.product.admin_id == current_user.id  }.uniq.compact.reverse
        order_serializer = OrderSerializer.new(list_order)
        render json: {
          status: HTTP_OK[:code],
          data: order_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
        }
    end

    def order_action
        order = Order.find_by id: params[:id]
        if order.present? &&  order.update(is_confirmed: params[:is_confirmed])
            order_serializer = OrderSerializer.new(order)
            render json: {
              status: HTTP_OK[:code],
              data: order_serializer.serializable_hash[:data][:attributes]
            }
        else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "Order not found")
        end
    end

    def booking_action
        booking = Booking.find_by id: params[:id]
        if booking.present? &&  booking.update(is_confirmed: params[:is_confirmed])
            booking_serializer = BookingSerializer.new(booking)
            render json: {
              status: HTTP_OK[:code],
              data: booking_serializer.serializable_hash[:data][:attributes]
            }
        else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "Booking not found")
        end
    end

    def user_booking
        if current_user.class.name == 'User'
            product = Product.find_by id: params[:product_id]
            if product.present? && product.category.category_type.eql?('booking')
                booking = current_user.booking.new(product_id: params[:product_id], booking_date: params[:booking_date])
                if booking.booking_date.present?
                    if booking.save
                        booking_serializer = BookingSerializer.new(booking)
                        render json: {
                          status: HTTP_OK[:code],
                          message: 'Your Order Received And Our Vendor Contact You As Soon As Possible.',
                          data: booking_serializer.serializable_hash[:data][:attributes]
                        }
                    else
                        error_response_with_obj(HTTP_BAD_REQUEST[:code], "Booking not saved.")
                    end
                else
                    error_response_with_obj(HTTP_BAD_REQUEST[:code], "Booking date invalid.")
                end
            else
                error_response_with_obj(HTTP_BAD_REQUEST[:code], "Select Booking category for book order.")
            end
        else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "Admin Can't do booking. please login as normal user.")
        end
    end

    def user_order
        if current_user.class.name == 'User'
            if params[:is_cart].present? && params[:address].present? && params[:city_name].present? &&  params[:area_name].present?
                address = current_user.address.create(street_1: params[:address], city_name: params[:city_name], area_name: params[:area_name])
                order_list = []
                if params[:is_cart].eql?('true')
                    current_user.carts.each do |cart|
                        order = current_user.order.create(order_date: Date.today, order_receive_date: Date.today+6.days, product_id: cart.product_id, address_id: address.id)
                        order_list.push(current_user.products_orders_sizes_colors.create(product_id: cart.product_id, order_id: order.id, size_id: cart.size_id, color_id: cart.color_id))
                    end
                    current_user.carts.delete_all
                else
                    order = current_user.order.create(order_date: Date.today, order_receive_date: Date.today+6.days, product_id: params[:product_id], address_id: address.id)
                    params[:color_id].split(",").each do |color|
                        params[:size_id].split(",").each do |size|
                            order_list.push(current_user.products_orders_sizes_colors.create(product_id: params[:product_id], order_id: order.id, size_id: size, color_id: color))
                        end
                    end
                end
                order_serializer = ProductordersizecolorsSerializer.new(order_list)
                render json: {
                      status: HTTP_OK[:code],
                      data: order_serializer.serializable_hash[:data].map{ |data| data[:attributes]}
                    }
            else
                error_response_with_obj(HTTP_BAD_REQUEST[:code], "Params Missing.")
            end
        else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "Admin Can't do booking. please login as normal user.")
        end
    end

    def order_booking
        if current_user.class.name == 'User'
            booking_orders = {}
            booking = current_user.booking
            product_size_color = current_user.products_orders_sizes_colors
            order_serializer = ProductordersizecolorsSerializer.new(product_size_color)
            booking_serializer = BookingSerializer.new(booking)
            booking_orders.merge!("booking" => booking_serializer.serializable_hash[:data].map{ |data| data[:attributes]})
            booking_orders.merge!("order" => order_serializer.serializable_hash[:data].map{ |data| data[:attributes]})
            render json: {
                status: HTTP_OK[:code],
                data: booking_orders
            }
        else
            error_response_with_obj(HTTP_BAD_REQUEST[:code], "please login as normal user.")
        end
    end

end
