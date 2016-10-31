class Link < ApplicationRecord
  validate :valid_url
  belongs_to :user

  def valid_url
    URI.parse(url)
  rescue URI::InvalidURIError
    errors.add(:url, 'URL must be valid')
  end
end
