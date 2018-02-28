require 'net/http'

class DexOnline
  attr_reader :json_body

  def initialize query
    response = Net::HTTP.get_response search_url(query)
    if response.is_a?(Net::HTTPRedirection)
      response = Net::HTTP.get_response make_url(response["location"])
    end
    @json_body = JSON.parse(response.body).with_indifferent_access["definitions"]
  end

  def call
    json_body.first(2).map do |entry|
      "<entry>#{entry['htmlRep']}</entry>"
    end.join("<br/>").html_safe
  end

  private

  def search_url query
    URI("https://dexonline.ro/definitie/#{URI.encode(query)}?format=json")
  end

  def make_url path
    URI("https://dexonline.ro#{path}")
  end

end
