require 'rails_helper'

describe 'User can sign in', type: :feature do
  scenario 'visitor sees a link to sign in' do
    visit root_path

    expect(page).to have_link('Sign in')
  end

  scenario 'they are taken to login page when they click "Sign in"' do
    visit root_path

    click_link 'Sign in'

    expect(current_path).to eq('/sign_in')
  end

  scenario 'they sign in and a session gets created' do
    existing_user = FactoryGirl.create(:user)
    visit '/sign_in'

    fill_in 'session[email_address]', with: 'bob@gmail.com'
    fill_in 'session[password]', with: 'password'
    click_button 'Sign in'

    expect(
      page.get_rack_session['user_id']
    ).to eq(existing_user.id)
  end

  scenario 'they are taken to the links index' do
    existing_user = FactoryGirl.create(:user)
    visit '/sign_in'

    fill_in 'session[email_address]', with: 'bob@gmail.com'
    fill_in 'session[password]', with: 'password'
    click_button 'Sign in'

    expect(current_path).to eq('/links')
  end

  scenario 'they see an option to logout' do
    existing_user = FactoryGirl.create(:user)
    visit '/sign_in'

    fill_in 'session[email_address]', with: 'bob@gmail.com'
    fill_in 'session[password]', with: 'password'
    click_button 'Sign in'

    within('.primary-nav') do
      expect(page).to have_link('Sign out')
    end
  end

  context 'invalid login credentials' do
    scenario 'they see an ambiguous error message' do
      visit '/sign_in'
      fill_in 'session[email_address]', with: 'bob@gmail.com'
      fill_in 'session[password]', with: 'password'
      click_button 'Sign in'

      within('.flash_danger') do
        expect(page).to have_text('Invalid login credentials')
      end
    end

    scenario 'no session gets created' do
      visit '/sign_in'
      fill_in 'session[email_address]', with: 'bob@gmail.com'
      fill_in 'session[password]', with: 'password'
      click_button 'Sign in'

      expect(
        page.get_rack_session['user_id']
      ).to eq(nil)
    end

    scenario 'they are not taken to links index' do
      visit '/sign_in'
      fill_in 'session[email_address]', with: 'bob@gmail.com'
      fill_in 'session[password]', with: 'password'
      click_button 'Sign in'

      expect(current_path).to eq('/sign_in')
    end
  end
end
