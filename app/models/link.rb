class Link < ApplicationRecord
  validates :url, url: true
  belongs_to :user
  after_create :mark_unread

  def mark_unread
    self.read = false
  end
end
