require 'rails_helper'

RSpec.describe 'sessions', type: :feature, js: true do
  feature 'Creation of sessions' do
    before(:all) do
      @user = create(:user)
    end

    scenario 'login' do
      visit new_session_path
      sleep(1)
      fill_in 'Username', with: @user.username
      sleep(1)
      find('input[type="submit"]').click
      sleep(1)
      expect(page).to have_text 'Log in'
      sleep(1)
    end
  end
end
