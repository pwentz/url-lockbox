require 'rails_helper'

describe 'User can search their links by title', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @existing_link = FactoryGirl.create(:link, user: @user)
    session_hash = { user_id: @user.id }
    page.set_rack_session(session_hash)
  end

  context 'matching link exists' do
    scenario 'matching link appears' do
      visit '/links'

      fill_in 'link-search', with: 'Gi'

      within('.links') do
        expect(page).to have_link('Github')
      end
    end
  end

  context 'matching link does not exist' do
    scenario 'nothing appears' do
      visit '/links'

      fill_in 'link-search', with: 'Mo'

      within('.links') do
        expect(page).not_to have_link('Github')
      end
    end
  end
end
