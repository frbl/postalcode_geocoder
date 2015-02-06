# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postalcode_geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = "postalcode_geocoder"
  spec.version       = PostalcodeGeocoder::VERSION
  spec.authors       = ["Frank Blaauw"]
  spec.email         = ["f.j.blaauw@umcg.nl"]
  spec.summary       = %q{Application to determine a longtitude and latitude of a dutch postal code}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['determine_postalcode']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'virtus'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'dotenv'
end
