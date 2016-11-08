class Link < ApplicationRecord
  validates :url, url: true
  validates :title, presence: true
  belongs_to :user
  before_create :mark_unread

  def mark_unread
    self.read = false
  end
end
