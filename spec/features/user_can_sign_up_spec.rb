require 'rails_helper'

describe 'User can sign up', type: :feature do
  scenario 'they see the create account button when not signed in' do
    visit root_path

    expect(page).to have_link('Create Account')
  end

  scenario 'they click the "Create Account" link and are taken to form page' do
    visit root_path

    click_link 'Create Account'

    expect(current_path).to eq('/users/new')
    expect(page).to have_selector('input')
  end

  scenario 'they fill in form and user is created' do
    visit new_user_path

    fill_in 'user[email_address]', with: 'bob@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    expect{
      click_button 'Create account'
    }.to change{User.count}.from(0).to(1)
  end

  scenario 'the session gets set with their user_id' do
    visit new_user_path

    fill_in 'user[email_address]', with: 'bob@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Create account'

    expect(
      page.get_rack_session['user_id']
    ).to eq(1)
  end

  scenario 'the user gets taken to the links index page' do
    visit new_user_path

    fill_in 'user[email_address]', with: 'bob@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Create account'

    expect(current_path).to eq('/links')
  end

  context 'passwords do not match' do
    scenario 'they receive an error message' do
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'sandwich'
      click_button 'Create account'

      expect(page).to have_text('Passwords do not match')
    end

    scenario 'the user does not get created' do
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'sandwich'
      click_button 'Create account'

      expect(User.count).to eq(0)
    end

    scenario 'no session gets created' do
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'sandwich'
      click_button 'Create account'

      expect(
        page.get_rack_session['user_id']
      ).to eq(nil)
    end
  end

  context 'email address has already been taken' do
    scenario 'they receive an error message' do
      existing_user = FactoryGirl.create(:user)
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Create account'

      expect(page).to have_text('Email address has already been taken')
    end

    scenario 'the user does not get created' do
      existing_user = FactoryGirl.create(:user)
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Create account'

      expect(User.count).to eq(1)
    end

    scenario 'no session gets stored' do
      existing_user = FactoryGirl.create(:user)
      visit new_user_path

      fill_in 'user[email_address]', with: 'bob@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Create account'

      expect(
        page.get_rack_session['user_id']
      ).to eq(nil)
    end
  end
end
