require 'rails_helper'

RSpec.describe IncomingController, type: :controller do
  describe "POST create" do
    before do
      FactoryGirl.create(:user)
      post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"
      @bookmark = Bookmark.last
    end

    # it "should receive sender params" do
    # end
    it "should receive subject params" do
      expect(@bookmark.topic.title).to eq("category")
    end
    it "should receive body params" do
      expect(@bookmark.url).to eq("http://example.com")
    end
  end
end
