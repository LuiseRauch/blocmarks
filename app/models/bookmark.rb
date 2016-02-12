class Bookmark < ActiveRecord::Base
  # require 'uri'

  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :topic, presence: true
  validates :user, presence: true, on: :create
  validates :url, presence: true, uniqueness: { scope: :topic_id, message: '%{value} has already been saved to this topic.' }
  validates :url, format: { with: URI::regexp(%w(http https))}

  # def valid?(url)
  #   uri = URI.parse(url)
  #   uri.kind_of?(URI::HTTP)
  # rescue URI::InvalidURIError
  #   false
  # end
end
