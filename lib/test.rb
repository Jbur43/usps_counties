require './usps_counties.rb'

# puts Usps.get_city_state_abbrv("22203").inspect
# puts Usps.state_from("22203").inspect
# puts Usps.city_from("22203").inspect
# puts Usps.state_name_from("AL")
# puts Usps.population_from("Alabama")

zip_code_location = Usps::County.new('167THEBO3702', '08691').get_county_info
puts "city: #{zip_code_location.city}"
puts "state_abbrv: #{zip_code_location.state_abbrv}"
