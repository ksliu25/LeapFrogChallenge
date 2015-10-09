require 'spec_helper'

describe LeapFrog do
	describe "#search" do
		let(:url){"http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35"}

		it "should return a hash object if the http request is successful" do
			stub_request(:get, url)
			.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"propensity": 0.26532, "ranking": "C"}', :headers => {})
			expect(LeapFrog.search(url)).to be_a(Hash)
		end

		it "should return a string after making 3 attempts" do			
			expect(LeapFrog.search(url)).to be_a(String)
		end

		
	end

end