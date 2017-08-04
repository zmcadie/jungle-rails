class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to "/products/#{@review.product_id}"
    end
  end

  def destroy
    @review = Review.find params[:id]
    Products.reviews.delete(@review.id)
  end

  private

  def require_login
    unless current_user
      redirect_to :products
    end
  end

  def review_params
    params.require(:review).permit(
      :product_id,
      :user_id,
      :description,
      :rating
    )
  end

end
