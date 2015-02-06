module PostalcodeGeocoder
  module Sessions
    class Session
      attr_reader :api_site
      attr_reader :default_timeout

      def initialize(api_site: ENV['GEOLOCATION_API_SITE'], timeout: nil)
        @api_site = api_site
        @default_timeout = timeout
      end

      def get(timeout: default_timeout, ** params)
        perform_request_or_fail do
          HTTParty.get(full_api_url,
                       headers: headers,
                       query: augment_params(params),
                       timeout: timeout)
        end
      end

      private

      def perform_request_or_fail(&block)
        response = yield
        case response.code
          when 200..299, 422
            response
          when 401
            Rails.warn('Access denied!')
          else
            fail response.parsed_response || "Error, code: #{response.code}"
        end
      end

      def full_api_url
        api_site + format
      end

      def format
        'json'
      end

      def augment_params(params)
        params['key'] = ENV['GEOLOCATION_API_KEY'] if ENV['GEOLOCATION_API_KEY']
        params
      end

      def headers
        {}
      end
    end
  end
end