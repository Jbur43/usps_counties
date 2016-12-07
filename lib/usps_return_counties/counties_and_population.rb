require 'csv'

module UspsReturnCounties
  module CountiesAndPopulation
    def self.counties_and_population_from(state_name)
      Constants::STATE_COUNTY_POPULATION_HASH[state_name]
    end
  end
end

