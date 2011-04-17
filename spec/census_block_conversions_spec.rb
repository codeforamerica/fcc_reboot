require 'helper'

describe FccReboot, ".census_block" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('census-block-conversions-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    client = FccReboot.client
    client.CensusBlock(:latitude => '38.0', :longitude => '-77.5')
    a_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      should have_been_made
  end

  it "should return the correct results" do
    client = FccReboot.client
    services = client.CensusBlock(:latitude => '38.0', :longitude => '-77.5')
    services.should be_a Hash
    services["Block"]["FIPS"].should == '510339905003000'
  end
end