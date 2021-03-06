require 'embedly'
require 'json'

class TopicsController < ApplicationController

  def index
    # @topics = Topic.all
    @topics = policy_scope(Topic)
  end

  def show
     @topic = Topic.friendly.find(params[:id])
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new
    @topic.title = params[:topic][:title]
    @topic.user = current_user
    authorize @topic

    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.friendly.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(params[:id])
    @topic.title = params[:topic][:title]
    authorize @topic

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.friendly.find(params[:id])
    authorize @topic

    if @topic.destroy_if_no_bookmarks
      if !@topic.destroyed?
      # if Topic.exists?(id: @topic.id)
        flash[:notice] = "\"#{@topic.title}\" can not be deleted because other users added links, but we have deleted your bookmarks."
        redirect_to @topic
      else
        flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
        redirect_to topics_path
      end
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end
end
