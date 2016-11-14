require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  subject(:goal) { Goal.create!(body: "THIS IS MY GOAL!", viewable: true, completed: false, user_id: 1) }
  let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, id: goal.id
    end
  end

  describe "POST #create" do
    it "Validates presence of goal's attributes " do
      post :create, goal: { body: "THIS IS MY GOAL!", viewable: true, completed: nil, user_id: 1 }
      expect(response).to render_template(:new)
      expect(flash[:errors]).to be_present
    end

    context "with valid params" do
      it "redirects user to user show on success" do
        post :create, goal: { body: "THIS IS MY GOAL!", viewable: true, completed: false, user_id: 1 }
        expect(response).to redirect_to(goals_url)
      end
    end
  end

  describe "PUT #update" do
    context "when logged in as a different user" do

      before do
        allow(controller).to receive(:current_user) { jack }
      end

  end
end
