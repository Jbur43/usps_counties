require_relative 'city_state_info'
require_relative 'zip_code_location'

module UspsCounties
  class CityStateCounty
    attr_reader :usps_id, :zip

    def initialize(usps_id, zip)
      @usps_id = usps_id
      @zip = zip
    end

    def get_info
      city = UspsCounties::CityStateInfo.city_from(usps_id, zip)
      state_abbrv = UspsCounties::CityStateInfo.state_abbrv_from(usps_id, zip)
      state_name = UspsCounties::CityStateInfo.state_name_from(state_abbrv)
      counties_populations = UspsCounties::CityStateInfo.counties_and_population_from(state_name)
      UspsCounties::ZipCodeLocation.new(city, state_abbrv, state_name, counties_populations)
    end
  end
end
