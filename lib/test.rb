require './usps_counties/city_state_county'

# puts Usps.get_city_state_abbrv("22203").inspect
# puts Usps.state_from("22203").inspect
# puts Usps.city_from("22203").inspect
# puts Usps.state_name_from("AL")
# puts Usps.population_from("Alabama")

# zip_code_location = UspsCounties::County.new(=, '08691').get_county_info
# puts "city: #{zip_code_location.city}"
# puts "state_abbrv: #{zip_code_location.state_abbrv}"

usps_id = '167THEBO3702'
zip = '08691'
<<<<<<< Updated upstream
# puts UspsCounties::CityStateCounty.new(usps_id, zip).get_info.inspect
result = UspsCounties::CityStateCounty.new(usps_id, zip).get_info
puts result.city
puts result.state_abbrv
puts result.state_name
puts result.counties_populations
=======
puts UspsCounties::CityStateCounty.new(usps_id, zip).get_info.inspect
>>>>>>> Stashed changes
