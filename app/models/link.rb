class Link < ApplicationRecord
  validates :url, url: true
  validates :title, presence: true
  belongs_to :user
  before_create :mark_unread
  before_save :set_html_values

  def mark_unread
    self.read = false
  end

  def set_html_values
    parser = WebParser.new(url)
    self.html_h1 = parser.first_h1
    self.html_title = parser.title
  end
end
