require 'nokogiri'

class WebParser
  def initialize(domain)
    @doc = Nokogiri::HTML(open(domain))
  end

  def first_h1
    @doc.css('h1').text
    # if h1.children && title.children.first
    #   h1.children.first.text
    # end
    # @doc.css('h1').children.first.text
  end

  def title
    @doc.css('title').text
    # if title.children && title.children.first
    #   title.children.first.text
    # end
    # @doc.css('title').children.first.text
  end
end
