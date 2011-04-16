require 'simplecov'
SimpleCov.start
require File.expand_path('../../lib/fcc_reboot', __FILE__)
require 'rspec'
require 'webmock'

require 'fcc_reboot'

RSpec.configure do |config|
  config.include WebMock::API
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end