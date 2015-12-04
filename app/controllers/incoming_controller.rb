class IncomingController < ApplicationController
# http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
skip_before_action :verify_authenticity_token, only: [:create]

def create
  # assume that email body consists of url only
  incoming_url = params[:"body-plain"]
  incoming_email = params[:sender]
  incoming_topic = params[:Subject]

  # create new user if not existing
  bookmark_user = User.find_or_create_by!(:email => incoming_email)

  # create new topic if not existing
  bookmark_topic = Topic.find_or_create_by!(:title => incoming_topic, :user_id => bookmark_user.id)

  # create new bookmark if not existing
  @bookmark = Bookmark.find_or_create_by!(:url => incoming_url, :topic_id => bookmark_topic.id)

  # Assuming all went well.
  head 200

end
end
