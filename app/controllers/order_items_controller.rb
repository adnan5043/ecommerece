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
        @order.update_subtotal # Add this line to recalculate subtotal
        flash[:success] = 'Item was successfully added to the cart.'
        format.js # This will render create.js.erb
      else
        # ... (unchanged code)
      end
    end
  end


  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if @order_item.update(order_params)
      # Handle successful update, if needed
    else
      # Handle update failure, if needed
    end

    @order_items = current_order.order_items
    respond_to do |format|
      format.js
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
    flash[:error] = "OrderItem not found"
  end
end


  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end

