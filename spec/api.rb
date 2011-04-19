require 'helper'

describe FccReboot do
  after do
    FccReboot.reset
  end

  describe ".respond_to?" do
    it "should return true if method exists" do
      FccReboot.respond_to?(:client, true).should be_true
    end
  end

  describe ".client" do
    it "should be a FccReboot::Client" do
      FccReboot.client.should be_a FccReboot::Client
    end
  end
end

describe FccReboot, ".broadband_test" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/speedtest/find').
    with(:query => {:format => 'json', :latitude => '38.0', :longitude => '-77.5'}).
    to_return(:body => fixture('broadband_test.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.broadband_test({:latitude => '38.0', :longitude => '-77.5'})
    a_request(:get, 'http://data.fcc.gov/api/speedtest/find').
    with(:query => {:format => 'json', :latitude => '38.0', :longitude => '-77.5'}).
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
      with(:query => {:format => 'json', :latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('census-block-conversions-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.find_census_block(:latitude => '38.0', :longitude => '-77.5')
    a_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:format => 'json', :latitude => '38.0', :longitude => '-77.5'}).
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
      with(:query => {:format => 'json', :stateCode => 'IL', :multi => 'Yes'}).
      to_return(:body => fixture('frn-conversions-getlist.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
    stub_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:format => 'json', :stateCode => 'IL', :multi => 'No'}).
      to_return(:body => fixture('frn-conversions-getlist.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.frn_getlist(:stateCode => 'IL', :multi => true)
    a_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:format => 'json', :stateCode => 'IL', :multi => 'Yes'}).
      should have_been_made
  end
  
  it "should request the correct resource" do
    FccReboot.frn_getlist(:stateCode => 'IL', :multi => false)
    a_request(:get, 'http://data.fcc.gov/api/frn/getList').
      with(:query => {:format => 'json', :stateCode => 'IL', :multi => 'No'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.frn_getlist(:stateCode => 'IL', :multi => false)
    services.should be_a Array
    services.first["frn"].should == '0017855545'
  end
end

describe FccReboot, ".frn_getinfo" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/frn/getInfo').
      with(:query => {:format => 'json', :frn => '0017855545'}).
      to_return(:body => fixture('frn-conversions-getinfo.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.frn_getinfo(:frn => '0017855545')
    a_request(:get, 'http://data.fcc.gov/api/frn/getInfo').
      with(:query => {:format => 'json', :frn => '0017855545'}).
      should have_been_made
  end
  
  it "should return the correct results" do
    services = FccReboot.frn_getinfo(:frn => '0017855545')
    services.should be_a Hash
    services["frn"].should == '0017855545'
  end
end

describe FccReboot, ".get_spectrum_bands" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getSpectrumBands').
      with(:query => {:format => 'json', :frequencyFrom=>'226', :frequencyTo => '900'}).
      to_return(:body => fixture('get_spectrum_bands.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')
    a_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getSpectrumBands').
      with(:query => {:format => 'json', :frequencyFrom=>'226', :frequencyTo => '900'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')
    services.should be_a Array
    services[0]["upperBand"].should == "235"
  end
end

describe FccReboot, ".get_spectrum_licenses" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getLicenses').
      with(:query => {:format => 'json', :name=> 'AT', :radioservice=>'Cellular'}).
      to_return(:body => fixture('get_licenses.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_spectrum_licenses(:name=> 'AT', :radioservice=>'Cellular')
    a_request(:get, 'http://data.fcc.gov/api/spectrum-view/services/advancedSearch/getLicenses').
      with(:query => {:format => 'json', :name=> 'AT', :radioservice=>'Cellular'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.get_spectrum_licenses(:name=> 'AT', :radioservice=>'Cellular')
    services.should be_a Array
    services[0]["id"].should == "11538"
  end
end

describe FccReboot, ".get_licenses" do
  before do
    @query = {:searchValue => 'Verizon%20Wireless', :format =>'json'}
    @bad_query = {:searchValue => 'some name', :format =>'json'}
    stub_request(:get, 'http://data.fcc.gov/api/license-view/basicSearch/getLicenses').
      with(:query => @query).
      to_return(:body => fixture('license-view-get-licenses.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
    stub_request(:get, 'http://data.fcc.gov/api/license-view/basicSearch/getLicenses').
      with(:query => @bad_query).
      to_return(:body => fixture('license-view-get-licenses-error.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_licenses(@query)
    a_request(:get, 'http://data.fcc.gov/api/license-view/basicSearch/getLicenses').
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    licenses = FccReboot.get_licenses(@query)
    licenses.should be_a Array
    licenses[0]["licenseID"].should == '2300007967'
  end
  
  it "should return the correct results" do
    licenses = FccReboot.get_licenses(@bad_query)
    licenses.should be_a Hash
    licenses["Errors"]["Err"][0]["code"].should == '110'
  end
end

describe FccReboot, ".get_common_names" do
  before do
    @query = {:commonName => 'Sprint%20Nextel', :limit => '10', :format => 'json'}
    @url = 'http://data.fcc.gov/api/license-view/licenses/getCommonNames'
    stub_request(:get, @url).
      with(:query => @query).
      to_return(:body => fixture('license-view-get-common-names.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_common_names(@query)
    a_request(:get, @url).
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    common_names = FccReboot.get_common_names(@query)
    common_names.should be_a Array
    common_names[0]["statCount"].should == '11989'
  end
end

describe FccReboot, ".get_statuses" do
  before do
    @query = {:commonName => 'Sprint%20Nextel', :limit => '10', :format => 'json'}
    @url = 'http://data.fcc.gov/api/license-view/licenses/getStatuses'
    stub_request(:get, @url).
      with(:query => @query).
      to_return(:body => fixture('license-view-get-statuses.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_statuses(@query)
    a_request(:get, @url).
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    statuses = FccReboot.get_statuses(@query)
    statuses.should be_a Array
    statuses[0]["statCount"].should == '43980'
  end
end

describe FccReboot, ".get_issued" do
  before do
    @query = {:commonName => 'Sprint%Nextel', :format => 'json'}
    stub_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getIssued').
      with(:query => @query).
      to_return(:body => fixture('get_issued.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_issued(@query)
    a_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getIssued').
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    licenses = FccReboot.get_issued(@query)
    licenses.should be_a Array
    licenses[0]["statDesc"].should == '2001'
  end
end

describe FccReboot, ".get_renewals" do
  before do
    @query = {:commonName => 'Sprint%Nextel', :format => 'json'}
    stub_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getRenewals').
      with(:query => @query).
      to_return(:body => fixture('get_renewals.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_renewals(@query)
    a_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getRenewals').
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    licenses = FccReboot.get_renewals(@query)
    licenses.should be_a Array
    licenses[0]["statDesc"].should == '201104'
  end
end

describe FccReboot, ".get_entities" do
  before do
    @query = {:commonName => 'Sprint%Nextel', :format => 'json'}
    stub_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getEntities').
      with(:query => @query).
      to_return(:body => fixture('get_entities.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_entities(@query)
    a_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getEntities').
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    licenses = FccReboot.get_entities(@query)
    licenses.should be_a Array
    licenses[0]["statDesc"].should == 'Individual'
  end
end

describe FccReboot, ".get_categories" do
  before do
    @query = {:commonName => 'Sprint%Nextel', :limit=>"10", :format => 'json'}
    stub_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getCategories').
      with(:query => @query).
      to_return(:body => fixture('get_entities.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.get_categories(@query)
    a_request(:get, 'http://data.fcc.gov/api/license-view/licenses/getCategories').
      with(:query => @query).
      should have_been_made
  end

  it "should return the correct results" do
    licenses = FccReboot.get_categories(@query)
    licenses.should be_a Array
    licenses[0]["statDesc"].should == 'Individual'
  end
end
