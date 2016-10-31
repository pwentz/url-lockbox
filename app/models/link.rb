class Link < ApplicationRecord
  validate :valid_url
  belongs_to :user
  after_create :mark_unread

  def mark_unread
    self.read = false
  end

  def valid_url
    URI.parse(url)
  rescue URI::InvalidURIError
    errors.add(:url, 'URL must be valid')
  end
end
