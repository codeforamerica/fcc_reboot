require 'fcc_reboot/version'
require ::File.expand_path('../fcc_reboot/configuration.rb', __FILE__)
require 'fcc_reboot/client'

module FccReboot
  extend Configuration

  # Alias for FccReboot::Client.new
  #
  # @return [FccReboot::Client]
  def self.client(options={})
    FccReboot::Client.new(options)
  end

  # Delegate to FccReboot::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Custom error class for rescuing from all FccReboot errors
  class Error < StandardError; end

  # Raised when FccReboot returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when FccReboot returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when FccReboot returns a 403 HTTP status code
  class Forbidden < Error; end

  # Raised when FccReboot returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when FccReboot returns a 406 HTTP status code
  class NotAcceptable < Error; end

  # Raised when FccReboot returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when FccReboot returns a 502 HTTP status code
  class BadGateway < Error; end

  # Raised when FccReboot returns a 503 HTTP status code
  class ServiceUnavailable < Error; end
end
