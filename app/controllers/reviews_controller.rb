class ReviewsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:edit, :create, :show, :update, :destroy, :new]
  before_filter :load_product, :only => [:new]
  
  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = @product.reviews.build
    @review.user_id = current_user.id

    # render "/products/show"
    redirect_to product_path(@product)
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to products_path, notice: 'Review created successfully'
    else
      render :new
    end
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
