module ApplicationHelper
  def current_order
    if user_signed_in?
      current_user.orders.in_progress.first_or_create
      elsif !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      order = Order.create
      session[:order_id] = order.id
      order
    end
  end
end
