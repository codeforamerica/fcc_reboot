module FccReboot
  class Client
    module BroadbandTest
      # Provide a list of acceptable 311 service request types and their associated service codes
      #
      # @format :xml
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_List
      # @example Provide a list of acceptable 311 service request types and their associated service codes
      #   Open311.service_list
      def find(options={})
        response = get('find', options)
        unpack_if_xml(response) do
          response['result']
        end
      end
      
      private
      
      def unpack_if_xml(response)
        if format.to_s.downcase == 'xml'
          yield
        else
          response
        end
      end
      
    end
  end
end
