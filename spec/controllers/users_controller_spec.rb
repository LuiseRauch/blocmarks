require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:my_user) { create(:user) }
  let (:topic) { create(:topic, user: my_user) }
  let(:my_bookmark) { create(:bookmark, topic: topic, user: my_user) }

  describe "GET #show" do
    before do
      my_user.confirm
      sign_in my_user
    end

    it "returns http success" do
      get :show, id: my_user.id
      # /users/:id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_user.id
      expect(response).to render_template :show
    end

    it "renders the current_user #show view" do
      get :show, id: 500
      expect(assigns(:user)).to eq my_user
    end

    it "returns my_users bookmarks" do
      get :show, {id: my_user.id}
      expect(assigns(:user_bookmarks)).to eq [my_bookmark]
    end

    # it "returns my_users liked bookmarks" do
    #   get :show, id: my_user.id
    #   like = my_user.likes.where(bookmark: my_bookmark).create
    #   expect(assigns(:user_liked_bookmarks)).to eq (my_bookmark)
    # end
  end


end
