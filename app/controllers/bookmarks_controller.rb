class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.friendly.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.url = params[:bookmark][:url]
    @topic = Topic.friendly.find(params[:topic_id])
    @bookmark.topic = @topic
    @bookmark.user = current_user
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was saved."
      redirect_to [@topic]
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
    cookies[:before_edit] = request.referer
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @topic = Topic.friendly.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.url = params[:bookmark][:url]
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was updated."
      if cookies[:before_edit].present?
        before_edit = cookies[:before_edit]
        cookies[:before_edit] = nil
        redirect_to(before_edit)
      else
        redirect_to [@bookmark.topic]
      end
    else
      flash[:error] = "There was an error updating the bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @likes = @bookmark.likes
    @foreign_likes = @likes.where.not(user_id: @bookmark.user_id)
    authorize @bookmark

    if @foreign_likes.any?
      # @foreign_likes.each do |bookmark|
      #   bookmark.user_id = bookmark.likes.where.not(user_id: bookmark.id).first.user_id
      #   bookmark.create
    flash[:notice] = "\"#{@bookmark.url}\" was not deleted because it is liked by someone else."
    redirect_to @bookmark.topic
    elsif @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to @bookmark.topic
    else
      flash[:error] = "There was an error deleting the bookmark. Please try again."
      render :show
    end
  end
end
