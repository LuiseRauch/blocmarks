class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  scope :recent, -> { where('created_at > ?', 1.week.ago) }

  validates :title, length: { minimum: 1, maximum: 100 }, presence: true
  validates :user, presence: true
end
