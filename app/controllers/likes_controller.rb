class LikesController < ApplicationController
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    # @like = current_user.likes.build(bookmark: @bookmark)
    @like = Like.find_or_initialize_by(bookmark: @bookmark, user: current_user)
    # @like = like
    authorize @like

      if @like.save
        # Add code to generate a success flash and redirect to @bookmark
        flash[:notice] = "Bookmark liked."
      else
        # Add code to generate a failure flash and redirect to @bookmark
        flash[:error] = "Liking failed."
      end

      if request.referer.present?
        redirect_to(:back)
      else
        redirect_to [@bookmark.topic]
      end
  end

  def destroy
    # Get the bookmark from the params
    # Find the current user's like with the ID in the params
    @bookmark = Bookmark.find(params[:bookmark_id])
    # @like = current_user.likes.find(params[:id])
    @like = Like.find(params[:id])
    # @like = like
    authorize @like

      if @like.destroy
        # Flash success and redirect to @bookmark
        flash[:notice] = "Bookmark unliked."
      else
        # Flash error and redirect to @bookmark
        flash.now[:alert] = "Unliking failed."
      end
      
      if request.referer.present?
        redirect_to(:back)
      else
        redirect_to [@bookmark.topic]
      end
  end
end
