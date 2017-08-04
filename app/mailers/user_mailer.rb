class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def email_receipt(order)
    @order = order
    mail(to: "#{@order.email}", subject: "Order \##{@order.id}")
    puts "it worked!"
  end
end
