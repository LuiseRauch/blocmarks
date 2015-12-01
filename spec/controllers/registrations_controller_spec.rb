require 'rails_helper'


RSpec.describe Devise::RegistrationsController, type: :controller do
   let (:new_user_attributes) do
    {
        username: "BlocHead",
        email: "blochead@bloc.io",
        password: "blochead",
        password_confirmation: "blochead"
    }
  end

  describe "GET new" do
    it "returns http success" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to have_http_status(:success)
    end
    it "instantiates a new user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(:new_user_attributes).to_not be_nil
    end
  end

  describe "POST create" do
    it "returns http success" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end
    it "creates a new user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect{post :create, user: new_user_attributes}.to change(User, :count).by(1)
    end
    it "sets user name properly" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: new_user_attributes
      expect(assigns(:user).username).to eq new_user_attributes[:username]
    end
    it "sets user email properly" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end
    it "sets user password properly" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end
    it "sets user password_confirmation properly" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end
  end
end
