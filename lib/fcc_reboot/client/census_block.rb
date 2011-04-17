require 'JSON'

module FccReboot
  class Client
    module CensusBlock
      # Provide a list of acceptable 311 service request types and their associated service codes
      #
      # @format :xml
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_List
      # @example Provide a list of acceptable 311 service request types and their associated service codes
      #   Open311.service_list
      def FindCensusBlock(options={})
        response = get('block/find', options)
        JSON.parse(response)
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
