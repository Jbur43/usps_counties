require "test_helper"
require "nokogiri"
require "webmock/minitest"

API_URL = "http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup&XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
INVALID_URL = "http://produion.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup&XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"

class UspsTest < Minitest::Test
  def test_that_it_returns_city_and_state
    parsed_response = xml_fixture("usps.xml")

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html

    assert_equal "TRENTON", city
    assert_equal "NJ", state_abbrv
  end

  def test_that_it_does_not_return_city_state
    parsed_response = xml_fixture("usps_blank.xml")

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html

    assert_equal "", city
    assert_equal "", state_abbrv
  end

  def test_that_it_gets_the_correct_url
    first_url_part = "http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup".freeze
    second_url_part = "XML=<CityStateLookupRequest USERID='167THEBO3702'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
    joined_url = [first_url_part, second_url_part].join("&")
    assert joined_url == API_URL
  end

  def test_that_it_has_a_version_number
    refute_nil UspsCounties::VERSION
  end
end
