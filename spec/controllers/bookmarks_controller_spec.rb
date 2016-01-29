require 'rails_helper'
include RandomData

RSpec.describe BookmarksController, type: :controller do
  let (:my_user) { create(:user) }
  let (:my_topic) { create(:topic, user: my_user) }
  let (:my_bookmark) { create(:bookmark, topic: my_topic, user: my_user) }

  context "guest" do
    describe "GET new" do
      it "returns http redirect" do
        get :new, topic_id: my_topic.id
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_url = RandomData.random_sentence
        put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to redirect_to(topics_path)
      end
    end
  end


  context "logged in user doing CRUD on a bookmark they do not own" do
    before do
      other_user = User.new(username: "Test User", email: "test@example.com", password: "helloworld", password_confirmation: "helloworld")
      other_user.confirm
      sign_in other_user
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      it "initializes @bookmark" do
        get :new, topic_id: my_topic.id
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Bookmark by 1" do
        expect{post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}}.to change(Bookmark,:count).by(1)
      end
      it "assigns Bookmark.last to @bookmark" do
        post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}
        expect(assigns(:bookmark)).to eq Bookmark.last
      end
      it "redirects to the new bookmark" do
        post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}
        expect(response).to redirect_to [my_topic, Bookmark.last]
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_url = RandomData.random_sentence
        put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to redirect_to(topics_path)
      end
    end
  end

  context "logged in user doing CRUD on a bookmark they own" do

    before do
      my_user.confirm
      sign_in my_user
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end
      it "initializes @bookmark" do
        get :new, topic_id: my_topic.id
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Bookmark by 1" do
        expect{post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}}.to change(Bookmark,:count).by(1)
      end
      it "assigns Bookmark.last to @bookmark" do
        post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}
        expect(assigns(:bookmark)).to eq Bookmark.last
      end
      it "redirects to the new bookmark" do
        post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url}
        expect(response).to redirect_to [my_topic, Bookmark.last]
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to have_http_status(:success)
      end
      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to render_template :edit
      end
      it "assigns bookmark to be updated to @bookmark" do
        get :edit, topic_id: my_topic.id, id: my_bookmark.id
        bookmark_instance = assigns(:bookmark)
        expect(bookmark_instance.id).to eq my_bookmark.id
        expect(bookmark_instance.url).to eq my_bookmark.url
      end
    end

    describe "PUT update" do
      it "updates bookmark with expected attributes" do
        new_url = RandomData.random_url
        put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}
        updated_bookmark = assigns(:bookmark)
        expect(updated_bookmark.id).to eq my_bookmark.id
        expect(updated_bookmark.url).to eq new_url
      end
      it "redirects to the updated bookmark" do
        new_url = RandomData.random_url
        # Update: /topics/1/bookmarks/1 ... Body: params{} # => topic_id doesn't match bookmark
        put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {url: new_url}
        expect(response).to redirect_to [my_topic, my_bookmark]
        # bookmark = my_bookmark
        # put :update, topic_id: bookmark.topic_id, id: bookmark.id, bookmark: {url: new_url}
        # expect(response).to redirect_to [bookmark.topic, bookmark]
      end
    end

    describe "DELETE destroy" do
      it "deletes the bookmark" do
        delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
        count = Bookmark.where({id: my_bookmark.id}).size
        expect(count).to eq 0
      end
      it "redirects to topic show" do
        delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
        expect(response).to redirect_to my_topic
        # delete :destroy, topic_id: my_bookmark.topic_id, id: my_bookmark.id
        # expect(response).to redirect_to my_bookmark.topic
      end
    end
  end
end
