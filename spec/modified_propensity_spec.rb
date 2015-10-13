require_relative 'spec_helper'

describe "modified_propensity" do 
	subject(:url){"http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35"}
	let(:arg){{:income => 50000, :zipcode => 60201, :age => 35}}
	let(:wrong_arg){{:income => 50000, :zipcode => 60201}}


	it "should puts the modified propensity on a successful search" do
		stub_request(:get, url)
		.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
    	to_return(:status => 200, :body => '{"propensity": 0.26532, "ranking": "C"}', :headers => {})
		expect { modified_propensity(arg) }.to output.to_stdout
	end

	it "should puts a No response from API otherwise" do
		stub_request(:get, url)
		.with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'not_real.com', 'User-Agent'=>'Ruby'}).
    	to_return(:status => [500, "Internal Server Error"])
		expect { modified_propensity(arg) }.to output.to_stdout
	end

	it "should provide context when provided a hash with a missing key" do
		expect(modified_propensity(wrong_arg)).to eq("You must provide a hash with income, zipcode, and age! Error: 'key not found: :age'")
	end

	it "should provide context when provided with an argument not a hash" do
		p modified_propensity(50000)
		expect(modified_propensity(50000)).to eq("You must provide a hash with income, zipcode, and age! Error: 'undefined method `fetch' for 50000:Fixnum'")
	end


end