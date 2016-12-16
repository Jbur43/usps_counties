require_relative 'constants'
require_relative 'counties_and_population'
require 'rest_client'
require 'nokogiri'

module UspsCounties
  module CityStateInfo
    USPS_URL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze

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

    def self.city_state_abbrv(usps_id, zip)
      city_state ||= get_city_state_abbrv(usps_id, zip)
    end

    def self.state_abbrv_from(usps_id, zip)
      city_state_abbrv(usps_id, zip)[1]
    end

    def self.city_from(usps_id, zip)
      city_state_abbrv(usps_id, zip)[0]
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
end
