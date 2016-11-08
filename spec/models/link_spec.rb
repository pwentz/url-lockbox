require 'rails_helper'

describe Link, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }

    it 'validates url' do
      link = Link.create(title: 'My link',
                         url: 'dumb url')

      expect(link.errors.full_messages).to include('Url is not a valid URL')
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
