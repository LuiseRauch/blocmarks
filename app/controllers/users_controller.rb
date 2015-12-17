class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @user = current_user
    @user_bookmarks = @user.bookmarks.order(:topic_id)
    @topics = @user_bookmarks.collect(&:topic)
    #@user_liked_bookmarks = @user.likes.collect(&:bookmark)
    @user_liked_bookmarks = @user.liked_bookmarks.order(:topic_id)
  end
end
