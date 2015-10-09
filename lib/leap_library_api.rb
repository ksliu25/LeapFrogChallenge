require 'net/http'
require 'json'

HTTP_ERRORS = [
  EOFError,
  Errno::ECONNREFUSED,
  Errno::ECONNRESET,
  Errno::EINVAL,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError,
  Net::HTTPGatewayTimeOut,
	Timeout::Error,
]

module LeapFrog

	def self.search(url)
		retries = 3
		begin
			uri = URI("#{url}")
			json_object = Net::HTTP.get(uri)
		rescue *HTTP_ERRORS => e
			if e == Timeout::Error || Net::HTTPGatewayTimeOut
				puts "Retrying #{retries} more times"
			  puts e
			  retries -= 1
			  sleep(1)
			  retry unless retries < 1
			else
				return "#{e}" unless json_object
			end
		end
		return "No response from API" unless json_object
		return JSON.parse(json_object)
	end
	
	def self.propensity(url)
		json_hash = search(url)
		json_hash.is_a?(Hash) ? json_hash["propensity"] : "No response from API"
	end

end

