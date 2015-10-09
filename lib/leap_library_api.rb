require 'net/http'
require 'json'

module LeapFrog

	def self.search(url)
		retries = 3
		begin
			uri = URI("#{url}")
			json_object = Net::HTTP.get(uri)
		rescue Exception => e
		  puts "Retrying #{retries} more times"
		  retries -= 1
		  sleep(1)
		  retry unless retries < 1
		end
		return "No response from API" unless json_object
		return JSON.parse(json_object)
	end
	
	def self.propensity(url)
		json_hash = search(url)
		json_hash.is_a?(Hash) ? json_hash["propensity"] : "No response from API"
	end

end

