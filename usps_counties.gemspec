# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "usps_counties/version"

Gem::Specification.new do |spec|
  spec.name          = "usps_counties"
  spec.version       = UspsCounties::VERSION
  spec.authors       = ["Jbur43"]
  spec.email         = ["jtburum@gmail.com"]

  spec.summary       = "USPS API wrapper that also returns county data and population of that county"
  spec.description   = "Uses USPS API to return State Abbrv and City for a Zip code. Then maps the state abbreviation to a full state name. Finally takes the state name and returns a list of counties and their population"
  spec.homepage      = "https://github.com/Jbur43/usps_counties"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 2.1"
end
