class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @user = current_user
    @user_bookmarks = @user.bookmarks.order(:topic_id)
    @user_bookmarks_topics = @user_bookmarks.group_by(&:topic)

    @user_liked_bookmarks = @user.likes.collect(&:bookmark)
    @user_liked_bookmarks_topics = @user_liked_bookmarks.group_by(&:topic)
  end
end
