# require "usps_return_counties/version"
require 'nokogiri'
require 'rest_client'
require './usps_return_counties/counties_and_population'
require './usps_return_counties/constants'
require './usps_return_counties/zip_code_location'

USPS_URL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze
ROOT     = 'CityStateLookupResponse'.freeze

module UspsReturnCounties
  def self.get_city_state_abbrv(usps_id, zip)
    api_url = url(zip, usps_id)
    xml_response = RestClient.get(api_url)
    parsed_response = Nokogiri::XML(xml_response)

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html
    [city, state_abbrv]
  rescue => ex
    { error: ex.message }
  end

  def self.method(usps_id, zip)
    var ||= get_city_state_abbrv(usps_id, zip)
  end

  def self.state_abbrv_from(usps_id, zip)
    method(usps_id, zip)[1]
  end

  def self.city_from(usps_id, zip)
    method(usps_id, zip)[0]
  end

  def self.state_name_from(state_abbrv)
    Constants::STATES[state_abbrv.to_sym]
  end

  def self.counties_and_population_from(state_name)
    CountiesAndPopulation.counties_and_population_from(state_name)
  end

  def self.url(zip, usps_id)
    [USPS_URL, query_xml(zip, usps_id)].join('&')
  end

  def self.query_xml(zip, usps_id)
    "XML=<CityStateLookupRequest USERID='#{usps_id}'><ZipCode ID='0'><Zip5>#{zip}</Zip5></ZipCode></CityStateLookupRequest>"
  end
end

module UspsReturnCounties
  class UspsReturnCountiesInit
    attr_reader :usps_id, :zip

    def initialize(usps_id, zip)
      @usps_id = usps_id
      @zip = zip
    end

    def get_city_state_abbrv
      UspsReturnCounties.get_city_state_abbrv(usps_id, zip)
    end

    usps_county = UspsReturnCounties::UspsReturnCountiesInit.new('167THEBO3702', '08691').some_next_method

    city = UspsReturnCounties.city_from(usps_county.usps_id, usps_county.zip)
    state_abbrv = UspsReturnCounties.state_abbrv_from(usps_county.usps_id, usps_county.zip)
    state_name = UspsReturnCounties.state_name_from(state_abbrv)
    counties_populations = UspsReturnCounties.counties_and_population_from(state_name)

    zip_code_location = UspsReturnCounties::ZipCodeLocation.new(city, state_abbrv, state_name, counties_populations)
    puts "zip_code_location.city: #{zip_code_location.city}"
    puts "zip_code_location.state_name: #{zip_code_location.state_name}"
    puts "zip_code_location.state_abbrv: #{zip_code_location.state_abbrv}"
    puts "zip_code_location.county: #{zip_code_location.counties_populations.inspect}"
  end
end
