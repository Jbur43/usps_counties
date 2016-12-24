# Usps

Summary: USPS API wrapper that also returns county data and population of that county for a given United States Zip Code.

Description: Uses USPS API to return State Abbrv and City for a Zip code. Then maps the state abbreviation to a full state name. Finally takes the state name and returns a list of counties and their population.

```ruby
require 'usps_counties'

UspsCounties::CityStateCounty.new(usps_id, zip).get_info.inspect
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'usps_counties'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install usps_counties

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/usps_counties. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

