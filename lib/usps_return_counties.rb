# require "usps_return_counties/version"
require 'nokogiri'
require 'rest_client'
require './usps_return_counties/counties_and_population'
require './usps_return_counties/constants'

USPS_URL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze
ROOT     = 'CityStateLookupResponse'.freeze


# class MyGem
#   def initialize(user_id, zip)
#     @user_id = user_id
#     @zip = zip
#   end
# end
#   MyGem.new(user_id, zip).get_city_state(zip)

#   def self.get_city_state(zip)
#     UspsReturnCounties.get_city_state(user_id, zip)
#   end
# end

module UspsReturnCounties
  # will need to pass in User ID here
  def self.get_city_state_abbrv(zip)
    api_url = url(zip)
    xml_response = RestClient.get(api_url)
    parsed_response = Nokogiri::XML(xml_response)

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html
    [city, state_abbrv]
  rescue => ex
    { error: ex.message }
  end

  def self.state_from(zip)
    get_city_state_abbrv(zip)[1]
  end

  def self.city_from(zip)
    get_city_state_abbrv(zip)[0]
  end

  def self.state_name_from(state_abbrv)
    Constants::STATES[state_abbrv.to_sym]
  end

  def self.population_from(state_name)
    CountiesAndPopulation.counties_and_population_from(state_name)
  end

  def self.url(zip)
    [USPS_URL, query_xml(zip)].join('&')
  end

  def self.query_xml(zip)
    "XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>#{zip}</Zip5></ZipCode></CityStateLookupRequest>"
  end
end
