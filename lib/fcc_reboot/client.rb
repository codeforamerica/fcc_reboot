require ::File.expand_path('../client/connection', __FILE__)
require ::File.expand_path('../client/request', __FILE__)
require ::File.expand_path('../client/broadband_test.rb', __FILE__)
require ::File.expand_path('../client/census_block.rb', __FILE__)

module FccReboot
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = FccReboot.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include FccReboot::Client::Connection
    include FccReboot::Client::Request
    include FccReboot::Client::BroadbandTest  
    include FccReboot::Client::CensusBlock
  end
end
