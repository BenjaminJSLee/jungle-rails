class ReviewsController < ApplicationController
  
  before_action :require_login

  def create
    product = Product.find_by(id: params[:product_id])
    review = product.reviews.new(review_params)
    review.user = current_user
    if review.save
      
    end
    redirect_to product
  end

  def destroy
    product = Product.find_by(id: params[:product_id])
    review = Review.find params[:id]
    if current_user == review.user
      review.destroy
    end

    redirect_to product
  end

  private

  def require_login
    if current_user == nil
      redirect_to :login
    end
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end

end
