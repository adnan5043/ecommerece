class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(order_items: :product)
    @order = current_user.orders.last
  end

  def new
    @order = current_user.orders.find(params[:order_id])
  end
def create
  @order = current_user.orders.find(params[:order_id])
  @order.update_subtotal

  # Apply promo code discount if available
 if session[:discount].present?
    @order.subtotal *= (1 - session[:discount])
    session[:discount] = nil # Clear the discount from the session
  end

  charge = create_stripe_charge(@order.subtotal, params[:stripeToken])

  @order.order_items.each do |order_item|
    create_transaction(charge, order_item)
  end

  @order.update(status: 'paid')

  flash[:success] = 'Payment was successful!'
  redirect_to order_payments_path(order_id: @order)

rescue Stripe::CardError => e
  flash[:error] = e.message
  render :new
end


  private

  def create_stripe_charge(amount, stripe_token)
    Stripe.api_key = 'sk_test_51OHilMC6RwpJpsY7rgdWVJSESd48tGWOvE9yj6jBdtvfJpjY0EutV0R5yy1fikcFmjxFbD9dd3kmvTnzvdSBRhWA00U9Oj9Eve'

    # Use the updated subtotal here
    charge = Stripe::Charge.create(
      amount: (amount * 100).to_i,
      currency: 'usd',
      source: stripe_token,
      description: 'Order payment for a test Rails application'
    )

    # Update the order status after creating the charge
    @order.update(status: 'paid')

    charge
  end

  def create_transaction(charge, order_item)
    Transaction.create!(
      order: @order,
      title: order_item.product.title,
      price: order_item.product.price,
      quantity: order_item.quantity
    )
  end
end
