require 'fccreboot/client/connection'
require 'fccreboot/client/request'
require 'fccreboot/client/service'

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

    include FccReboot::Client::Service
  end
end