class CommentsController < ApplicationController
# app/controllers/comments_controller.rb

before_action :set_product
before_action :set_comment, only: [:edit, :update, :destroy]
before_action :check_comment_owner, only: [:edit, :update, :destroy]
before_action :check_comment_on_own_product, only: [:create]

def create
  @comment = @product.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
    redirect_to @product, notice: 'Comment was successfully created.'
  else
    # Handle validation errors
    render 'products/show'
  end
end

def edit
  # Fetch the comment to be edited
   @comment
end

def update
  if @comment.update(comment_params)
    redirect_to @product, notice: 'Comment was successfully updated.'
  else
    render :edit
  end
end

def destroy
  @comment.destroy
  redirect_to @product, notice: 'Comment was successfully deleted.'
end

private

def set_product
  @product = Product.find(params[:product_id])
end

def set_comment
  @comment = Comment.find(params[:id])
end

def check_comment_owner
  redirect_to @product, notice: 'You are not authorized to perform this action.' unless current_user.id == @comment.user_id
end

def check_comment_on_own_product
  redirect_to @product, notice: 'You cannot comment on your own product.' if current_user.id == @product.user_id
end

def comment_params
  params.require(:comment).permit(:content)
end

end
