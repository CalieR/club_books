class ReviewsController < ApplicationController
  def create
    review = Review.create(review_params.merge(user_id: current_user.id))
    redirect_to review.meeting.club
  end

  private

  def review_params
    params.require(:review).permit(:meeting_id, :rating)
  end
end
