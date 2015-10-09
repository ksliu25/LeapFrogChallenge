require 'net/http'
require 'json'

module LeapFrog

	def self.search(url)
		retries = 3
		begin
			uri = URI("#{url}")
			json_object = Net::HTTP.get(uri)
		rescue Exception => e
		  # response = error.io
		  # puts e
		  puts "Retrying #{retries} more times"
		  retries -= 1
		  sleep(2)
		  retry unless retries < 1
		end
		return "No response from url" unless json_object
		return JSON.parse(json_object)
	end
	
	def self.propensity(url)
		json_hash = search(url)
		json_hash.is_a?(Hash) ? json_hash["propensity"] : "No response from url"
	end

end

