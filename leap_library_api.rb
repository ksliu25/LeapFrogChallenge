require 'net/http'
require 'json'

module LeapFrog

	def self.propensity(url)
		json_object = search(url)
		hash = JSON.parse(json_object)
		return hash["propensity"]
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
		return json_object
	end

end