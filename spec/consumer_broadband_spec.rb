require 'helper'

describe FccReboot, ".find" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/speedtest/find?latitude=38.0&longitude=-77.5').
    to_return(:body => fixture('consumer-broadband-test-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.broadband_test({:latitude => '38.0', :longitude => '-77.5'})
    a_request(:get, 'http://data.fcc.gov/api/speedtest/find').
    with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
    should have_been_made
  end

  it "should return the correct results" do
    test = FccReboot.broadband_test({:latitude => '38.0', :longitude => '-77.5'})
    puts test.inspect
    test.should be_an Hash
    test["wirelineMaxDownload"].should == 17773.0
  end
end

