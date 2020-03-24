require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'sessions' do
    before(:all) do
      @user = create(:user)
    end
    it 'new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'create' do
      get :new
      post :create, params: { session: { username: @user.username } }
      expect(response).to have_http_status(302)
    end
  end
end
