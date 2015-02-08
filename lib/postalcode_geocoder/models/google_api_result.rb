module PostalcodeGeocoder
  module Models
    class GoogleApiResult
      include Virtus.model

      attribute :error_message, String
      attribute :status, String

      attribute :address_components, Array
      attribute :formatted_address, String
      attribute :geometry, Hash
      
      def latitude
        return nil unless geometry
        geometry['location']['lat']
      end

      def longitude
        return nil unless geometry
        geometry['location']['lng']
      end

      def self.from_api(model_hash)
        fail 'No results found' unless model_hash
        puts 'Warning: multiple results returned, using the first one' if model_hash['results'].size > 1
        if model_hash['results'].size >= 1
          status = model_hash['status']
          model_hash = model_hash['results'].first
          model_hash['status'] = status
        end
        new(model_hash)
      end
    end
  end
end