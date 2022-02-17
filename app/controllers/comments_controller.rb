
class CommentsController < ApplicationController
  before_action :set_restaurant

  def create
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path
    else
      @comment = @restaurant.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:notice] = "Comment has been created"
      else
        flash.now[:alert] = "Comment has not been created"
      end
      redirect_to restaurant_path(@restaurant)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
