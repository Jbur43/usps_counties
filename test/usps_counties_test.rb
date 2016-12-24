require "test_helper"
require "nokogiri"
require "webmock/minitest"
require "usps_counties/city_state_info"

API_URL = "http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup&XML=<CityStateLookupRequest USERID='fake_id'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"

class UspsTest < Minitest::Test
  def test_it_returns_city_and_state
    parsed_response = xml_fixture("usps.xml")

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html

    assert_equal "TRENTON", city
    assert_equal "NJ", state_abbrv
  end

  def test_it_does_not_return_city_state
    parsed_response = xml_fixture("usps_blank.xml")

    state_abbrv = parsed_response.xpath("//State").inner_html
    city = parsed_response.xpath("//City").inner_html

    assert_equal "", city
    assert_equal "", state_abbrv
  end

  def test_it_gets_the_correct_url
    first_url_part = "http://production.shippingapis.com/ShippingAPITest.dll?API=CityStateLookup".freeze
    second_url_part = "XML=<CityStateLookupRequest USERID='fake_id'><ZipCode ID='0'><Zip5>08691</Zip5></ZipCode></CityStateLookupRequest>"
    joined_url = [first_url_part, second_url_part].join("&")
    assert_equal joined_url, API_URL
  end

  def test_it_returns_full_state_name
    new_jersey = UspsCounties::Constants::STATES['NJ'.to_sym]
    assert_equal "New Jersey", new_jersey
  end

  def test_it_does_not_return_full_state_name
    return_blank = UspsCounties::Constants::STATES['MJ'.to_sym]
    assert_nil return_blank
  end

  def test_it_returns_county_and_population
    county, population = UspsCounties::CountiesAndPopulation.counties_and_population_from("New Jersey").last
    assert_equal "Warren County", county
    assert_equal "106869", population
  end

  def test_it_does_not_return_county_and_population
    county_and_population = UspsCounties::CountiesAndPopulation.counties_and_population_from("New Jery")
    assert_nil county_and_population
  end
end
