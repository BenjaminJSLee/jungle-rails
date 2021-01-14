class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def new_order_email(order)
    @order = order
    mail(
      to: @order.email,
      subject: "Order ##{@order.id} Receipt") do |format|
        format.html
        format.text 
      end
  end

end
