class Link < ApplicationRecord
  validates :url, url: true
  belongs_to :user
  before_create :mark_unread

  def mark_unread
    self.read = false
  end
end
