class OrderItemsController < ApplicationController
  def create
    @order = current_order || Order.create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:order_item][:product_id])
    if @order_item.persisted?
      @order_item.quantity += params[:order_item][:quantity].to_i
    else
      @order_item.quantity = params[:order_item][:quantity].to_i
    end
    respond_to do |format|
    if @order.save && @order_item.save
      session[:order_id] = @order.id
      @order.update_subtotal
      flash[:success] = 'Item was successfully added to the cart.'
      format.js
    else
        # Handle create failure, if needed
    end
    end
  end
  def check_promo_code
    promo_code = params[:promoCode]
    promo = PromoCode.find_by(code: promo_code)
    if promo && promo.valid_til >= Date.today
      session[:discount] = promo.discount
      render json: { discount: promo.discount }
    else
      session[:discount] = nil
      render json: { discount: nil, subtotal: current_order.subtotal }
    end
end
  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    respond_to do |format|
    if @order_item.update(order_params)
      # @order_items = @order.order_items
      @order.update_subtotal
      session[:order_id] = @order.id
      flash[:success] = 'Item was successfully updated in the cart.'
      format.js
    else
    # Handle update failure, if needed
    end
    end
  end
  def destroy
    @order_item = OrderItem.find_by(id: params[:id])
    @order = @order_item.order
    if @order_item
      @order_item.destroy
      @order.update_subtotal
      respond_to do |format|
      format.html { redirect_to card_path, notice: 'Item was successfully destroyed.' }
      format.json { render json: { subtotal: @order.subtotal } }
    end
    else
      flash[:error] = 'OrderItem not found'
    end
  end

  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
