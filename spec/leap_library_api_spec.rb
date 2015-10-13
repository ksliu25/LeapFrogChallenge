require 'spec_helper'

describe LeapFrog do
	subject(:url){"http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35"}
	subject(:leapfrog){LeapFrog.new(:income => 50000, :zipcode => 60201, :age => 35)}

	describe "#search" do
		it "should return a hash when the http request is successful" do
			stub_request(:get, url)
			.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"propensity": 0.26532, "ranking": "C"}', :headers => {})
			expect(leapfrog.search).to be_a(Hash)
		end

		it "should return the error message if it is an HTTP error" do
			stub_request(:get, url)
			.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
         to_return(:status => [500, "Internal Server Error"])
			expect(leapfrog.search).to eq("No response from API")
		end


		it "should return a string after making 3 attempts to timeout" do			
			stub_request(:get, url).to_raise(Timeout::Error)
			expect(leapfrog.search).to eq("No response from API")
		end

	end

end