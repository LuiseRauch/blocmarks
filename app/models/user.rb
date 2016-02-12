class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


   EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  has_many :topics
  has_many :bookmarks #, class_name: 'Bookmark', foreign_key: 'user_id'
  has_many :likes, dependent: :destroy
  has_many :liked_bookmarks, through: :likes, source: :bookmark

  after_destroy :reassign_topics_to_new_users

  validates :password, presence: true, length: { minimum: 6 }
  validates :email,
          presence: true,
          uniqueness: { case_sensitive: false },
          length: { minimum: 3, maximum: 100 },
          format: { with: EMAIL_REGEX }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end

  def reassign_topics_to_new_users
    topics = self.topics
    topics.each do |topic|
      if topic.bookmarks.where.not(user_id: self.id).any?
        topic.user_id = topic.bookmarks.where.not(user_id: self.id).first.user_id
        topic.save
      else
        topic.destroy
      end
    end
  end
end
