require 'rails_helper'

describe HomeController do

  context "GET index" do
    it "responds with success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end