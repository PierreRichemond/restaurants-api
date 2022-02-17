
class CommentsController < ApplicationController
  before_action :set_restaurant
  before_action :set_comment, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    comment_user = User.find(@comment.user_id)
    if comment_user == current_user
      if @comment.update(comment_params)
        flash[:notice] = 'Comment has been updated to the API'
        redirect_to root_path
      else
        flash.now[:alert] = 'Comment has not been updated'
        render edit_restaurant_comment_path(@restaurant)
      end
    else
      flash[:danger] = "You can only edit your own comment."
      redirect_to root_path
    end
  end

  def destroy
    comment_user = User.find(@comment.user_id)
    unless comment_user == current_user
      @comment.destroy
      flash[:notice] = 'Comment has been Removed from the Api'
      redirect_to root_path
    else
      flash.now[:alert] = 'You can only delete your own restaurant.'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
