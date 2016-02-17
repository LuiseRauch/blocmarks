class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user
  has_many :bookmarks

  scope :recent, -> { where('created_at > ?', 1.week.ago) }

  validates :title, length: { minimum: 1, maximum: 100 }, presence: true
  validates :user, presence: true

  # use instead of :destroy
  def destroy_if_no_bookmarks
    my_bookmarks = bookmarks.where(user_id: self.user_id)
      my_bookmarks.each do |bookmark|
        bookmark.destroy
      end
    foreign_bookmarks = bookmarks.where.not(user_id: self.user_id)
    if foreign_bookmarks.none?
      self.destroy
    else
      return true
    end
  end
end
