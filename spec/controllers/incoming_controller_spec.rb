require 'rails_helper'
include RandomData

RSpec.describe IncomingController, type: :controller do
  describe "POST create" do
    context "existing user creating a new topic and bookmark" do
      before do
        user = User.create!(email: "test@example.com", password: "helloworld", password_confirmation: "helloworld")
      end

      it "should test if a new topic is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Topic, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.topic.title).to eq("category")
      end
      it "should test if a new bookmark is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Bookmark, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.url).to eq("http://example.com")
      end
    end

    context "existing user adding a bookmark to an existing topic" do
      before do
        user = User.create!(email: "test@example.com", password: "helloworld", password_confirmation: "helloworld")
        topic = Topic.create!(title: "category")
      end

      it "should test if no new topic is created" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Topic, :count).by(0)
      end

      it "should test if the bookmark created and added to the existing topic and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Bookmark, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.url).to eq("http://example.com")
      end
    end

    context "newly created user creating a new topic and bookmark" do
      it "should test if user is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(User, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.topic.user.email).to eq("test@example.com")
      end
      it "should test if a new topic is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Topic, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.topic.title).to eq("category")
      end
      it "should test if a new bookmark is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Bookmark, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.url).to eq("http://example.com")
      end
    end

    context "newly created user adding a bookmark to an existing topic" do
      before do
        topic = Topic.create!(title: "category")
      end

      it "should test if user is created and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(User, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.topic.user.email).to eq("test@example.com")
      end

      it "should test if no new topic is created" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Topic, :count).by(0)
      end

      it "should test if the bookmark created and added to the existing topic and correctly assigned" do
        expect{post :create, sender: "test@example.com", subject: "category", :'body-plain' => "http://example.com"}.to change(Bookmark, :count).by(1)
        @bookmark = Bookmark.last
        expect(@bookmark.url).to eq("http://example.com")
      end
    end
  end
end