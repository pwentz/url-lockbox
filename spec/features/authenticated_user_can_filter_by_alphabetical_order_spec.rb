require 'rails_helper'

describe 'User can filter links by alphabetical order', type: :feature, js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:link, user: @user, title: 'Github')
    FactoryGirl.create(:link, user: @user, title: 'Apple')

    session_hash = { user_id: @user.id }
    page.set_rack_session(session_hash)
  end

  scenario 'links are not in alphabetical order' do
    visit '/links'

    expect(
      page.find('.links .link:nth-of-type(1)')
    ).to have_link('Github')

    expect(
      page.find('.links .link:nth-of-type(2)')
    ).to have_link('Apple')
  end
end
