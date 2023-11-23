class OrderItemsController < ApplicationController
def create
  @order = current_order
  @order_item = @order.order_items.find_or_initialize_by(product_id: params[:order_item][:product_id])

  # Ensure @order is not nil before accessing its id
  if @order && @order_item
    # If the item already exists in the order, update the quantity
    if @order_item.persisted?
      @order_item.quantity += params[:order_item][:quantity].to_i
    else
      # If it's a new item, set the quantity
      @order_item.quantity = params[:order_item][:quantity].to_i
    end

    respond_to do |format|
      if @order.save && @order_item.save
        session[:order_id] = @order.id
        format.js
      else
        error_messages = @order_item.errors.full_messages.join(', ')
        Rails.logger.error("Error saving order item: #{error_messages}")
        format.js { render 'create_failed', locals: { error_messages: error_messages } }
      end
    end
  else
    # Handle the case where @order or @order_item is nil
    Rails.logger.error("Error: @order or @order_item is nil.")
    respond_to do |format|
      format.js { render 'create_failed', locals: { error_messages: "Error: Order or order item is nil." } }
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
      respond_to do |format|
    format.html { redirect_to card_path, notice: 'Item was successfully destroyed.' }
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

