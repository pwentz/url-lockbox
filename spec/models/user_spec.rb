require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email_address) }
    it { should validate_presence_of(:email_address) }
    it { should validate_confirmation_of(:password) }
  end

  context 'associations' do
    it { should have_many(:links) }
  end
end
