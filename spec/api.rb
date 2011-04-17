require 'helper'

describe FccReboot, ".broadband_test" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/speedtest/find?latitude=38.0&longitude=-77.5').
    to_return(:body => fixture('broadband_test.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
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

describe FccReboot, ".census_block" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('census-block-conversions-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.find_census_block(:latitude => '38.0', :longitude => '-77.5')
    a_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.find_census_block(:latitude => '38.0', :longitude => '-77.5')
    services.should be_a Hash
    services["Block"]["FIPS"].should == '510339905003000'
  end
end

describe FccReboot, ".frn_getlist" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:stateCode => 'IL', :multi => 'Yes'}).
      to_return(:body => fixture('frn-conversions-getlist.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
    stub_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:stateCode => 'IL', :multi => 'No'}).
      to_return(:body => fixture('frn-conversions-getlist.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.frn_getlist(:stateCode => 'IL', :multi => true)
    a_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:stateCode => 'IL', :multi => 'Yes'}).
      should have_been_made
  end
  
  it "should request the correct resource" do
    FccReboot.frn_getlist(:stateCode => 'IL', :multi => false)
    a_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:stateCode => 'IL', :multi => 'No'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.frn_getlist(:stateCode => 'IL', :multi => false)
    services.should be_a Hash
    services["Frns"]["Frn"].first["frn"].should == '0017855545'
  end
end

describe FccReboot, ".frn_getinfo" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/frn/getInfo').
      with(:query => {:frn => '0017855545'}).
      to_return(:body => fixture('frn-conversions-getinfo.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.frn_getinfo(:frn => '0017855545')
    a_request(:get, 'http://data.fcc.gov/api/frn/getInfo').
      with(:query => {:frn => '0017855545'}).
      should have_been_made
  end
  
  it "should return the correct results" do
    services = FccReboot.frn_getinfo(:frn => '0017855545')
    services.should be_a Hash
    services["Info"]["frn"].should == '0017855545'
  end
end

describe FccReboot, ".get_spectrum_bands" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getSpectrumBands').
      with(:query => {:frequencyFrom=>'226', :frequencyTo => '900'}).
      to_return(:body => fixture('get_spectrum_bands.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')
    a_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getSpectrumBands').
      with(:query => {:frequencyFrom=>'226', :frequencyTo => '900'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')
    services.should be_a Array
    services[0]["upperBand"].should == "235"
  end
end

