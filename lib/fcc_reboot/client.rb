require 'fcc_reboot/client/connection'
require 'fcc_reboot/client/request'
require 'fcc_reboot/client/service'

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