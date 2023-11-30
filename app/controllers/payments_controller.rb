class PaymentsController < ApplicationController
  before_action :authenticate_user! # Add authentication as needed

  def new
    @order = current_user.orders.find(params[:order_id])
  end

  def create
    @order = current_user.orders.find(params[:order_id])

    # Set your Stripe API key here
    Stripe.api_key = 'sk_test_51OHilMC6RwpJpsY7rgdWVJSESd48tGWOvE9yj6jBdtvfJpjY0EutV0R5yy1fikcFmjxFbD9dd3kmvTnzvdSBRhWA00U9Oj9Eve'

    charge = Stripe::Charge.create(
      amount: (@order.subtotal * 100).to_i,
      currency: 'usd',
      source: params[:stripeToken],
      description: 'Payment for Order'
    )

    @order.update(status: 'paid')

    redirect_to root_path, notice: 'Payment was successful!'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
  end

end
