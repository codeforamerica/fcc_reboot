require 'helper'

describe FccReboot, ".broadband_test" do
  before do
    FccReboot.configure do |config|
      config.endpoint     = 'http://data.fcc.gov/api/speedtest/find'
    end
    stub_request(:get, 'http://data.fcc.gov/api/speedtest/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('consumer-broadband-test-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.broadband_test
    a_request(:get, 'http://data.fcc.gov/api/speedtest/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.broadband_test
    services.should be_an Array
    services.first.wirelineMaxDownload.should == '17773.0'
  end
end

describe FccReboot, ".broadband_test" do
  before do
    FccReboot.configure do |config|
      config.endpoint     = 'http://data.fcc.gov/api/speedtest/find'
    end
    stub_request(:get, 'http://data.fcc.gov/api/speedtest/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('consumer-broadband-test-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.broadband_test
    a_request(:get, 'http://data.fcc.gov/api/speedtest/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.broadband_test
    services.should be_an Array
    services.first.wirelineMaxDownload.should == '17773.0'
  end
end