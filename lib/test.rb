require './usps_counties.rb'

puts Usps.get_city_state_abbrv("22203").inspect
puts Usps.state_from("22203").inspect
puts Usps.city_from("22203").inspect
puts Usps.state_name_from("AL")
puts Usps.population_from("Alabama")
