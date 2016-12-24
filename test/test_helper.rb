$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "nokogiri"
require "minitest/autorun"

def xml_fixture(path)
  expanded_path = File.expand_path("../support/fixtures/#{path}", __FILE__)
  contents = File.read(expanded_path)
  Nokogiri::XML(contents)
end
