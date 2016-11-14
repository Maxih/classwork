require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of user's username and password" do
        post :create, user: {username: "Joe", password: ""}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates password is at least 6 characters long" do
        post :create, user: {username: "joe", password: "short"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

    end
  end



end
