module ApplicationHelper
  def current_order
      @current_order ||= current_user.orders.in_progress.first_or_create
  end

  private

  def find_or_create_order
    if session[:order_id].present?
      Order.find(session[:order_id])
    else
      order = Order.create
      session[:order_id] = order.id
      order
    end
  end
end

