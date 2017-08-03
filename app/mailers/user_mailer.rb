class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def email_receipt(order)
    mail(to: order.email, subject: "Order \##{order.id}")
  end
end
