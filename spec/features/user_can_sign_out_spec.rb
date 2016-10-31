require 'rails_helper'

describe 'User can sign out', type: :feature do
  context 'user is already authenticated' do
    scenario 'they see a link to sign out in the navbar' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      within('.primary-nav') do
        expect(page).to have_link('Sign out')
      end
    end

    scenario 'they do not see a link to sign in' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      within('.primary-nav') do
        expect(page).not_to have_link('Sign in')
      end
    end
  end

  context 'authenticated user has signed out' do
    scenario 'they are redirected back to root' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      click_link 'Sign out'

      expect(current_path).to eq('/')
    end

    scenario 'they see a link to sign in' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      click_link 'Sign out'

      expect(page).to have_link('Sign in')
    end

    scenario 'there is no more session' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      click_link 'Sign out'

      expect(
        page.get_rack_session['user_id']
      ).to eq(nil)
    end
  end
end
