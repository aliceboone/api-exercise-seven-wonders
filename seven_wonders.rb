require 'httparty'
require 'awesome_print'
require 'pry'

BASE_URL = "https://us1.locationiq.com/v1/search.php"
KEY = "pk.94740926b6cd4c11828d7ac78f8f23cd"
class SearchError < StandardError; end

def get_location(search_term)
  query = {
      q: search_term,
      key: KEY,
      format: "json",
  }
  response = HTTParty.get(BASE_URL, query: query)

  unless response.code == 200
    raise SearchError, "Cannot find #{search_term}"
  end

  return {
      search_term => {
          lat: response.first["lat"],
          lon: response.first["lon"]
      },
  }
end

def find_seven_wonders

  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end
