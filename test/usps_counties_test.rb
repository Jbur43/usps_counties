require 'test_helper'
require 'nokogiri'
require 'webmock/minitest'

API_URL = "http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup&XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
INVALID_URL = "http://produion.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup&XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
XML_DATA = "<?xml version='1.0' encoding='UTF-8'?>
<CityStateLookupResponse><ZipCode ID='0'><Zip5>08691</Zip5><City>TRENTON</City><State>NJ</State></ZipCode></CityStateLookupResponse>"

class UspsTest < Minitest::Test
  def test_that_it_returns_city_and_state
    parsed_response = Nokogiri::XML(XML_DATA)

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html

    assert state_abbrv == "NJ"
    assert city == "TRENTON"
  end

  def test_that_it_does_not_return_city_state
    parsed_response = Nokogiri::XML(XML_DATA)

    blank_body = parsed_response.xpath("//body").inner_html

    assert blank_body == ""
  end

  def test_that_it_gets_the_correct_url
    first_url_part = 'http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup'.freeze
    second_url_part = "XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
    joined_url = [first_url_part, second_url_part].join('&')
    assert joined_url == API_URL
  end

  def test_that_it_has_a_version_number
    refute_nil ::UspsCounties::VERSION
  end
end
