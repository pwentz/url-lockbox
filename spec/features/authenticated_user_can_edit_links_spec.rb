require 'rails_helper'

describe 'Authenticated user can edit links', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @existing_link = FactoryGirl.create(:link, user: @user)
    session_hash = { user_id: @user.id }
    page.set_rack_session(session_hash)
  end

  scenario 'they are taken to an edit page' do
    visit links_path

    click_link 'Edit'

    expect(current_path).to eq(edit_link_path(@existing_link))
  end

  context 'edits made are valid' do
    scenario 'they are taken back to the /links path' do
      visit edit_link_path(@existing_link)

      fill_in 'link[url]', with: 'https://google.com'
      fill_in 'link[title]', with: 'Google'
      click_button 'Update link'

      expect(current_path).to eq('/links')
    end

    scenario 'they see the updated link information' do
      visit edit_link_path(@existing_link)

      fill_in 'link[url]', with: 'https://google.com'
      fill_in 'link[title]', with: 'Google'
      click_button 'Update link'

      within('.links') do
        expect(page).to have_link('Google')
      end
    end
  end

  context 'edits made are invalid' do
    scenario 'they see a descriptive warning' do
      visit edit_link_path(@existing_link)

      fill_in 'link[url]', with: 'wow'
      fill_in 'link[title]', with: 'okay'
      click_button 'Update link'

      expect(page).to have_text('Url is not a valid URL')
    end

    scenario 'they do not go back to links page' do
      visit edit_link_path(@existing_link)

      fill_in 'link[url]', with: 'wow'
      click_button 'Update link'

      expect(current_path).not_to eq('/links')
    end
  end
end
