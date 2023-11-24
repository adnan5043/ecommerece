class ProductsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in
def index
  @products = Product.all
end

  def new
    @product = current_user.products.build
    @product.images.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end
  def show
  @product = Product.find(params[:id])
  @order_item = current_order.order_items.new
    @images = @product.images
     @comment = Comment.new
end

def edit
  @product = current_user.products.find(params[:id])
  num_additional_images = 1 - @product.images.size

  num_additional_images.times { @product.images.build }
end


  def update
    @product = current_user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :price,images_attributes: [:id, :image, :_destroy])
  end


end
