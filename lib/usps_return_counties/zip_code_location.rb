module UspsReturnCounties
  class ZipCodeLocation
    attr_reader :city, :state_abbrv, :state_name, :counties_populations

    def initialize(city, state_abbrv, state_name, counties_populations)
      @city = city
      @state_abbrv = state_abbrv
      @state_name = state_name
      @counties_populations = counties_populations
    end
  end
end
