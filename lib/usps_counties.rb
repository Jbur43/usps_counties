# require "usps_counties/version"
require 'nokogiri'
require 'rest_client'
require './usps_counties/counties_and_population'
require './usps_counties/constants'
require './usps_counties/zip_code_location'

USPS_URL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze
ROOT     = 'CityStateLookupResponse'.freeze

module Usps
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

module Usps
  class UspsInit
    attr_reader :usps_id, :zip

    def initialize(usps_id, zip)
      @usps_id = usps_id
      @zip = zip
    end


    usps_county = Usps::UspsInit.new('167THEBO3702', '08691')

    city = Usps.city_from(usps_county.usps_id, usps_county.zip)
    state_abbrv = Usps.state_abbrv_from(usps_county.usps_id, usps_county.zip)
    state_name = Usps.state_name_from(state_abbrv)
    counties_populations = Usps.counties_and_population_from(state_name)


    zip_code_location = Usps::ZipCodeLocation.new(city, state_abbrv, state_name, counties_populations)
    puts "zip_code_location: #{zip_code_location.inspect}"
  end
end
