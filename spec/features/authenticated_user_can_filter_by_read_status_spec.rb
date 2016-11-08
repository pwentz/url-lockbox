require 'rails_helper'

describe 'User can filter links by read status', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    session_hash = { user_id: @user.id }
    page.set_rack_session(session_hash)
  end

  context 'filter by read links' do
    before(:each) do
      read_links = FactoryGirl.create_list(:link,
                                           3,
                                           user: @user)
      @user.links.update({ read: true })
    end

    scenario 'all of the read links appear' do

      visit '/links'

      click_button 'Read'

      within('.links') do
        expect(page).to have_css('div.link', count: 3)
      end
    end

    scenario 'none of the unread links appear' do
      @user.links.last.update_attribute(:read, false)

      visit '/links'

      click_button 'Read'

      within('.links') do
        expect(page).to have_css('div.link', count: 2)
      end
    end
  end

  context 'filter by unread links' do
    before(:each) do
      FactoryGirl.create_list(:link, 3, user: @user)
    end

    scenario 'all of the unread links appear' do
      visit '/links'

      click_button 'Unread'

      within('.links') do
        expect(page).to have_css('div.link', count: 3)
      end
    end

    scenario 'none of the read links appear' do
      @user.links.last.update_attribute(:read, true)

      visit '/links'

      click_button 'Unread'

      within('.links') do
        expect(page).to have_css('div.link', count: 2)
      end
    end
  end
end
