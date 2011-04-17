require 'JSON'

module FccReboot
  class Client
    module Api
      # speed test statistics for a US County given the passed Latitude and Longitude
      #
      # @format :json
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://reboot.fcc.gov/developer/consumer-broadband-test-api
      # @example Provide speed test statistics for a US County given the passed Latitude and Longitude
      #   FccReboot.broadband_test(:latitude => '38.0', :longitude => '-77.5')
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
      
      # This API accepts a frequency range and returns a list of the frequency bands 
      # along with a high level description of how the band is allocated and for what uses within the 225 MHz and 3700 MHz frequency range.
      # @format :json
      # @key false
      # @param options [Hash] A customizable set of options:
      # frequencyFrom (Optional) – If a frequency range is not provided then the API will return all spectrum bands falling within the 225 to 3700 MHz range. Both a lower and upper frequency value must be provided when entering search criteria.
      # frequencyTo (Optional) – If a frequency range is not provided then the API will return all spectrum bands falling within the 225 to 3700 MHz range. Both a lower and upper frequency value must be provided when entering search criteria.
      # pageNum (Optional) – Default is 1.
      # sortColumn (Optional) – Default is lowerBand. Valid values are: lowerBand, upperBand, or desc.
      # sortOrder (Optional) – Default is asc. Valid values are: asc, desc.
      # pageSize (Optional) – Default value is 1000.
      # limit (Optional) – Default value is 100.
      # format (Optional) – Default value is xml. Valid values are: xml, json, jsonp
      # jsonCallback (Optional) – Default value is callback.
      # @return [Array]
      # @see http://reboot.fcc.gov/developer/spectrum-dashboard-api
      # @example Provide speed test statistics for a US County given the passed Latitude and Longitude
      #   FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')
      def get_spectrum_bands(options={})
        response = get('spectrum-view/services/advancedSearch/getSpectrumBands', options)
        JSON.parse(response)["SpectrumBands"]["SpectrumBand"]        
      end
      
      # This API returns a high level overview of who owns spectrum across the country 
      # within the 225 MHz to 3700 MHz frequency range in radio services deemed appropriate for 
      # mobile broadband use. 
      # @format :json
      # @key false
      # @param options [Hash] A customizable set of options:
      # frequencyFrom (Optional) – If a frequency range is not provided then the API will return all spectrum bands falling within the 225 to 3700 MHz range. Both a lower and upper frequency value must be provided when entering search criteria.
      # frequencyTo (Optional) – If a frequency range is not provided then the API will return all spectrum bands falling within the 225 to 3700 MHz range. Both a lower and upper frequency value must be provided when entering search criteria.
      # pageNum (Optional) – Default is 1.
      # sortColumn (Optional) – Default is lowerBand. Valid values are: lowerBand, upperBand, or desc.
      # sortOrder (Optional) – Default is asc. Valid values are: asc, desc.
      # pageSize (Optional) – Default value is 1000.
      # limit (Optional) – Default value is 100.
      # format (Optional) – Default value is xml. Valid values are: xml, json, jsonp
      # @return [Array]
      # @see http://reboot.fcc.gov/developer/spectrum-dashboard-api
      # @example Provide speed test statistics for a US County given the passed Latitude and Longitude
      #   FccReboot.get_license(:name=> 'AT', :radioservice=>'Cellular')
      def get_spectrum_licenses(options={})
        response = get('spectrum-view/services/advancedSearch/getLicenses', options)
        JSON.parse(response)["Licenses"]["License"]        
      end
      
    end
  end
end
