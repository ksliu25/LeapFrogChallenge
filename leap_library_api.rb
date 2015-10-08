require 'net/http'
require 'json'

module LeapFrog

	def self.propensity(url)
		json_hash = search(url)
		return json_hash["propensity"]
	end

	def self.search(url)
		retries = 3
		begin
			uri = URI("url")
			json_object = Net::HTTP.get(uri)
		rescue OpenURI::HTTPError => error
		  response = error.io
		  puts response.status
		  puts "Retrying #{retries} more times"
		  retries -= 1
		  sleep 120
		  retry
		end
		return JSON.parse(json_object)
	end

end