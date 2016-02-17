require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  it { should have_many(:bookmarks) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(1) }

  describe "destroy_if_no_bookmarks" do
    let(:other_user) { User.create!(email: "myotheruser@example.com", password: "helloworld", password_confirmation: "helloworld") }

    it "should just delete the users bookmarks if there are bookmarks of other users saved in it" do
      bookmark = create(:bookmark, topic: topic, user: user)
      bookmark_count = Bookmark.count
      expect{topic.destroy_if_no_bookmarks}.to change{Bookmark.count}.from(1).to(0)
    end
    it "should not delete the topic if there are bookmarks of other users saved in it" do
      bookmark = create(:bookmark, topic: topic, user: other_user)
      topic.destroy_if_no_bookmarks
      expect(topic.destroyed?).to eq false
    end
    it "should delete a topic if there are no bookmarks of other users saved in it" do
      bookmark = create(:bookmark, topic: topic, user: user)
      topic.destroy_if_no_bookmarks
      expect(topic.destroyed?).to eq true
    end
  end

end
