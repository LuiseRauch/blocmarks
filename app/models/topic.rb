class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  scope :recent, -> { where('created_at > ?', 1.week.ago) }
end
