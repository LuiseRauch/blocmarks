class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :topic, presence: true
  validates :user, presence: true, on: :create
  validates :url, presence: true, format: { with: URI::regexp(%w(http https))}, uniqueness: { scope: :topic_id, message: '%{value} has already been saved to this topic.' }

  # after_destroy :reassign_liked_bookmarks

  # asks users if they want to save a liked bookmark before its gone
  # def reassign_liked_bookmarks
  #   likes = self.likes
    # check if the bookmarks's likes belong to any other user
    # foreign_likes = likes.where.not(user_id: self.user_id)
    #   if foreign_likes.any?
    #     foreign_likes.each do |bookmark|
      #ask if you want to save the bookmark as yours

      #yes - save it
      #like.user_id = foreign_likes.first.user_id
      
      #current_user = self.user
      #self.save
      #no - unlike it
      #@like.destroy
  #   end
  # end

end
