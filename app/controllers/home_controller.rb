class HomeController < ApplicationController
   def index
    @products = Product.all
    @images = Image.all
    @product = Product.find_by(id: params[:product_id])
    @order_item = OrderItem.new

  end
end
