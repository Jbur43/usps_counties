# require "usps_return_counties/version"
require 'nokogiri'
require 'rest_client'
require 'usps_return_counties/counties_and_population'
require 'usps_return_counties/constants'

USPS_URL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze
ROOT     = 'CityStateLookupResponse'.freeze

module UspsReturnCounties
  # will need to pass in User ID here
  def self.get_city_state_abbrv(user_id, zip)
    api_url = url(zip, user_id)
    puts api_url
    xml_response = RestClient.get(api_url)
    parsed_response = Nokogiri::XML(xml_response)

    state_abbrv = parsed_response.xpath("//State").inner_html
    puts state_abbrv
    city = parsed_response.xpath("//City").inner_html
    puts [city, state_abbrv]
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

  def self.url(zip, user_id)
    [USPS_URL, query_xml(zip, user_id)].join('&')
  end

  def self.query_xml(zip, user_id)
    puts 'user id'
    puts user_id
    puts 'zip'
    puts zip
    "XML=<CityStateLookupRequest USERID=#{user_id}><ZipCode ID='0'><Zip5>#{zip}</Zip5></ZipCode></CityStateLookupRequest>"
  end
end

# 167THEBO3702

module UspsReturnCounties
  class UspsReturnCountiesInit
    attr_reader :user_id, :zip

    def initialize(user_id, zip)
      @user_id = user_id
      @zip = zip
    end

    get_county = UspsReturnCounties::UspsReturnCountiesInit.new('167THEBO3702', '08691')
    UspsReturnCounties.get_city_state_abbrv(get_county.user_id, get_county.zip)
  end
end

