require './usps_return_counties.rb'

puts UspsReturnCounties.get_city_state_abbrv("22203").inspect
puts UspsReturnCounties.state_from("22203").inspect
puts UspsReturnCounties.city_from("22203").inspect
puts UspsReturnCounties.state_name_from("AL")
puts UspsReturnCounties.population_from("Alabama")
