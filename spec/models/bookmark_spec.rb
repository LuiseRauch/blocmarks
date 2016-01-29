require 'rails_helper'
include RandomData

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, user: user, topic: topic) }

  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_many(:likes) }

  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:url) }

  describe "attributes" do
    it "should respond to url" do
      expect(bookmark).to respond_to(:url)
    end
  end
end
