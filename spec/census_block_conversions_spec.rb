describe FccReboot, ".census_block" do
  before do
    stub_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      to_return(:body => fixture('census-block-conversions-api.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
  end

  it "should request the correct resource" do
    FccReboot.census_block.find(:latitude => '38.0', :longitude => '-77.5')
    a_request(:get, 'http://data.fcc.gov/api/block/find').
      with(:query => {:latitude => '38.0', :longitude => '-77.5'}).
      should have_been_made
  end

  it "should return the correct results" do
    services = FccReboot.census_block.find(:latitude => '38.0', :longitude => '-77.5')
    services.should be_a Hash
    services.Block.FIPS.wirelineMaxDownload.should == '17773.0'
  end
end