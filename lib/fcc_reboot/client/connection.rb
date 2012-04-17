require 'faraday_middleware'
require 'faraday/response/raise_error'

module FccReboot
  class Client
    # @private
    module Connection
      private

      def connection(raw=false)
        options = {
          #:headers => {'Accept' => "*/#{format}", 'User-Agent' => user_agent},
          :headers => {'Accept' => 'application/json'},
          :ssl => {:verify => false},
          :url => 'http://data.fcc.gov/api/' + endpoint.to_s
        }

        Faraday::Connection.new(options) do |connection|
          connection.use Faraday::Request::Multipart
          unless raw
            connection.use Faraday::Response::Mashify
            case format.to_s.downcase
            when 'json'
              connection.use Faraday::Response::ParseJson
            when 'xml'
              connection.use Faraday::Response::ParseXml
            end
          end
          connection.use Faraday::Response::RaiseError
          connection.adapter(adapter)
        end
      end
    end
  end
end

