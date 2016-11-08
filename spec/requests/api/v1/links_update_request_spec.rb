require 'rails_helper'

describe 'Links update request', type: :request do
  context 'authenticated user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @existing_link = FactoryGirl.create(:link, user: @user)

      allow_any_instance_of(
        ApplicationController
      ).to receive(:current_user).and_return(@user)
    end

    scenario 'it updates the read attribute of the link' do
      put "/api/v1/links/#{@existing_link.id}", params: { read: true }

      expect{
        @existing_link.reload
      }.to change{ @existing_link.read }.from(false).to(true)
    end
  end

  context 'no authenticated user' do
    scenario 'it returns a 400' do
      user = FactoryGirl.create(:user)
      existing_link = FactoryGirl.create(:link, user: user)

      put "/api/v1/links/#{existing_link.id}", params: { read: true }

      expect(response).to have_http_status(400)
    end

    scenario 'it does not update the attribute of the link' do
      user = FactoryGirl.create(:user)
      existing_link = FactoryGirl.create(:link, user: user)

      put "/api/v1/links/#{existing_link.id}", params: { read: true }

      expect{
        existing_link.reload
      }.not_to change{ existing_link.read }
    end
  end
end
