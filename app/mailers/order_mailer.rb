class OrderMailer < ApplicationMailer
	def new_order_email_vendor
	    @order = params[:order]
	    mail(to: @order.product.admin.email, subject: "You got a new order!")
  	end

  	def new_order_email_user
	    @order = params[:order]
	    mail(to: @order.user.email, subject: "ShaadiWaale - Your order details!")
  	end
end
