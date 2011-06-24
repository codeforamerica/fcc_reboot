require 'fcc_reboot/configuration'
require 'fcc_reboot/client'
require 'fcc_reboot/version'

module FccReboot
  extend Configuration
  class << self
    # Alias for FccReboot::Client.new
    #
    # @return [FccReboot::Client]
    def client(options={})
      FccReboot::Client.new(options)
    end

    # Delegate to FccReboot::Client
    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      client.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
