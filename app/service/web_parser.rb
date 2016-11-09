require 'nokogiri'

class WebParser
  def initialize(domain)
    @doc = Nokogiri::HTML(open(domain))
  end

  def first_h1
    @doc.css('h1').text
  end

  def title
    @doc.css('title').text
  end
end
