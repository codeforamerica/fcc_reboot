require 'fcc_reboot/configuration'
require 'fcc_reboot/client'

module FccReboot
  extend Configuration
  class << self
    # Alias for FccReboot::Client.new
    #
    # @return [FccReboot::Client]
    def new(options={})
      FccReboot::Client.new(options)
    end

    # Delegate to FccReboot::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
