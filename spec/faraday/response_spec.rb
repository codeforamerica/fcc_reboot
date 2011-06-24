require 'helper'

describe Faraday::Response do
  {
    400 => Faraday::Error::ClientError,
    401 => Faraday::Error::ClientError,
    403 => Faraday::Error::ClientError,
    404 => Faraday::Error::ResourceNotFound,
    406 => Faraday::Error::ClientError,
    500 => Faraday::Error::ClientError,
    502 => Faraday::Error::ClientError,
    503 => Faraday::Error::ClientError,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_request(:get, 'http://data.fcc.gov/api/speedtest/find').
          with(:query => {:format => 'json', :latitude => '38.0', :longitude => '-77.5'}).
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          FccReboot.broadband_test({:latitude => '38.0', :longitude => '-77.5'})
        end.should raise_error(exception)
      end
    end
  end
end
