require "postalcode_geocoder/version"
require 'postalcode_geocoder/file_parser'
require 'postalcode_geocoder/sessions'
require 'postalcode_geocoder/models'
require 'postalcode_geocoder/csv_exporter'
require 'postalcode_geocoder/uncalculated_data_finder'

module PostalcodeGeocoder
  LONGITUDE_COLUMN = 'longitude'
  LATITUDE_COLUMN = 'latitude'

  class Collector
    def initialize
      @session = Sessions::Session.new
    end

    def run!(postal_code_list)
      results = {}
      over_quota = false
      postal_code_list.each do |postal_code|
	sleep 1.0/5.0
        puts "Processing #{postal_code}"
        address = convert_to_national_postalcode 'The Netherlands', postal_code
        result = @session.get(address: address, components: components('NL'))
        google_api_result = Models::GoogleApiResult.from_api(result)
        break if google_api_result.status != 'OK'
        results[postal_code] = google_api_result
      end
      results
    end

    def components(countrycode)
      "country:#{countrycode}"
    end

    def convert_to_national_postalcode(country, postalcode)
      "#{postalcode}, #{country}"
    end
  end
end
