require 'rails_helper'

describe 'Authenticated user can submit links', type: :feature do
  context 'user is authenticated' do
    scenario 'they see a new link form from links#index' do
      authenticated_user = FactoryGirl.create(:user)
      session_hash = { user_id: authenticated_user.id }
      page.set_rack_session(session_hash)

      visit links_path

      expect(page).to have_selector('form')
    end

    context 'valid link submitted' do
      scenario 'they stay on the same page' do
        authenticated_user = FactoryGirl.create(:user)
        session_hash = { user_id: authenticated_user.id }
        page.set_rack_session(session_hash)

        visit links_path

        fill_in 'link[url]', with: 'https://github.com'
        fill_in 'link[title]', with: 'Github'
        click_button 'Create link'

        expect(current_path).to eq(links_path)
      end

      scenario 'they see the links they created' do
        authenticated_user = FactoryGirl.create(:user)
        session_hash = { user_id: authenticated_user.id }
        page.set_rack_session(session_hash)

        visit links_path

        fill_in 'link[url]', with: 'https://github.com'
        fill_in 'link[title]', with: 'Github'
        click_button 'Create link'

        within('.links') do
          expect(page).to have_link('Github')
        end
      end

      scenario 'they only see their links' do
        authenticated_user = FactoryGirl.create(:user)
        random_user = FactoryGirl.create(:user, email_address: 'james@yahoo.com')
        random_user_link = FactoryGirl.create(:link, user: random_user)

        session_hash = { user_id: authenticated_user.id }
        page.set_rack_session(session_hash)

        visit links_path

        fill_in 'link[url]', with: 'https://google.com'
        fill_in 'link[title]', with: 'Google'
        click_button 'Create link'

        within('.links') do
          expect(page).not_to have_link('Github')
        end
      end
    end

    context 'invalid link is submitted' do
      scenario 'they see a descriptive error message' do
        authenticated_user = FactoryGirl.create(:user)
        session_hash = { user_id: authenticated_user.id }
        page.set_rack_session(session_hash)

        visit links_path

        fill_in 'link[url]', with: 'invalid url'
        fill_in 'link[title]', with: 'random domain'
        click_button 'Create link'

        within('#validation-errors') do
          expect(page).to have_text('URL must be valid')
        end
      end
    end
  end

  context 'user is not authenticated' do

  end
end
