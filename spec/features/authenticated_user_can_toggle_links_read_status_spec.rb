require 'rails_helper'

describe 'User can toggle link read status', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @existing_link = FactoryGirl.create(:link, user: @user)
    session_hash = { user_id: @user.id }
    page.set_rack_session(session_hash)
  end


  context 'link is unread' do
    scenario 'clicking the link changes it to "Mark as Unread"' do
      visit '/links'

      click_link 'Mark as Read'

      link = page.find('.mark-read')

      expect(link).to have_text('Mark as Unread')
    end
  end

  context 'link is read' do
    scenario 'clicking the link changes it to "Mark as Read"' do
      @existing_link.update_attribute(:read, true)

      visit '/links'

      click_link 'Mark as Unread'

      link = page.find('.mark-read')

      expect(link).to have_text('Mark as Read')
    end
  end

  scenario 'it updates the status of the link' do
    visit '/links'

    click_link 'Mark as Read'

    expect {
      @existing_link.reload
    }.to change{ @existing_link.read }.from(false).to(true)
  end
end
