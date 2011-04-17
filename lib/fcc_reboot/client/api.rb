require 'JSON'

module FccReboot
  class Client
    module Api
      # Provide a list of acceptable 311 service request types and their associated service codes
      #
      # @format :xml
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_List
      # @example Provide a list of acceptable 311 service request types and their associated service codes
      #   Open311.service_list
      def broadband_test(options={})
        response = get('speedtest/find', options)
        JSON.parse(response)["SpeedTestCounty"]
      end
      
      def find_census_block(options={})
        options.merge({:format => "json"})
        response = get('block/find', options)
        JSON.parse(response)
      end

      def frn_getlist(options={})
        options[:multi] = options[:multi] ? "Yes" : "No"
        options.merge({:format => "json"})
        response = get('frn/getList', options)
        JSON.parse(response)
      end
      
      def frn_getinfo(options={})
        options.merge({:format => "json"})
        response = get('frn/getInfo', options)
        JSON.parse(response)
      end
      
    end
  end
end
