require_relative 'spec_helper'

describe "modified_propensity" do 
	subject(:url){"http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35"}

	it "should puts the modified propensity on a successful search" do
		stub_request(:get, url)
		.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
    	to_return(:status => 200, :body => '{"propensity": 0.26532, "ranking": "C"}', :headers => {})
		expect { modified_propensity(url) }.to output.to_stdout
	end

	it "should puts a No response from API otherwise" do
		stub_request(:get, url)
		.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
    	to_return(:status => [500, "Internal Server Error"])
		expect { modified_propensity(url) }.to output.to_stdout
	end

end