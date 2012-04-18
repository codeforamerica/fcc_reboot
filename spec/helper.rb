unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end
require 'fcc_reboot'
require 'rspec'
require 'webmock/rspec'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
