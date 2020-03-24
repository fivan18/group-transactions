require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'sessions' do
    it 'new' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
