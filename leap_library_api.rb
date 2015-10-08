require 'net/http'
require 'json'

module LeapFrog

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
		return propensity(json_object)
	end

	def self.propensity(json)
		hash = JSON.parse(json)
		return hash["propensity"]
	end

	class << self
  	private :propensity
  end



end