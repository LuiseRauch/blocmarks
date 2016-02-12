include RandomData

class IncomingController < ApplicationController
# http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
skip_before_action :verify_authenticity_token, only: [:create]

def create
  # assume that email body consists of url only
  incoming_url = params[:"stripped-text"]
  incoming_email = params[:sender]
  incoming_topic = params[:subject]

  # create new user if not existing
  bookmark_user = User.find_or_create_by!(:email => incoming_email) do |user|
    user.password = RandomData.random_sentence
    user.password_confirmation = user.password
  end

  # create new topic if not existing
  bookmark_topic = Topic.find_or_initialize_by(:title => incoming_topic)
  bookmark_topic.user_id ||= bookmark_user.id
  bookmark_topic.save!

  # create new bookmark if not existing
  @bookmark = Bookmark.find_or_initialize_by(:url => incoming_url, :topic_id => bookmark_topic.id)
  @bookmark.user_id ||= bookmark_user.id
  @bookmark.save!

  # authorize @bookmark # will fail because user.present? false
  
  # send email if not correctly fromatted
  if !@bookmark.persisted? || @bookmark.nil?
    UrlMailer.oops(bookmark_user, @bookmark).deliver_now
  end
  # Assuming all went well.
  head 200
  end
end
