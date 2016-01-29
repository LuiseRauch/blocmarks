require 'rails_helper'
include RandomData

RSpec.describe LikesController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_topic) { create(:topic, user: my_user) }
  let (:my_bookmark) { create(:bookmark, topic: my_topic, user: my_user) }

  context "guest" do
    describe "POST create" do
      it "redirects the user to the topics view" do
        post :create, bookmark_id: my_bookmark.id
        expect(response).to redirect_to(topics_path)
      end
    end
    describe "DELETE destroy" do
      it "redirects the user to the topics view" do
        like = my_user.likes.where(bookmark: my_bookmark).create
        delete :destroy, bookmark_id: my_bookmark.id, id: like.id
        expect(response).to redirect_to(topics_path)
      end
    end
  end

  context "logged in user" do
    before do
      my_user.confirm
      sign_in my_user
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    describe "POST create" do
      it "redirects to the bookmarks show view" do
        post :create, bookmark_id: my_bookmark.id
        expect(response).to redirect_to "where_i_came_from"
      end
      it 'creates a like for the current user and specified bookmark' do
        expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).to be_nil
        post :create, bookmark_id: my_bookmark.id
        expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).not_to be_nil
      end
    end
    describe "DELETE destroy" do
      it "redirects to the bookmarks show view" do
        like = my_user.likes.where(bookmark: my_bookmark).create
        delete :destroy, bookmark_id: my_bookmark.id, id: like.id
        expect(response).to redirect_to "where_i_came_from"
      end
      it "destroys the like for the current user and bookmark" do
        like = my_user.likes.where(bookmark: my_bookmark).create
        expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).not_to be_nil
        delete :destroy, bookmark_id: my_bookmark.id, id: like.id
        expect(my_user.likes.find_by_bookmark_id(my_bookmark.id)).to be_nil
      end
    end
  end
end
