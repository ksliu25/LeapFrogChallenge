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

class LeapFrog

	def initialize(args={})
		@income = args[:income].to_s
		@zipcode = args[:zipcode].to_s
		@age = args[:age].to_s
	end

	def search
		retries = 3
		begin
			uri = URI("#{formatted_url}")
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

	private

	def formatted_url
		"http://not_real.com/customer_scoring?income=#{@income}&zipcode=#{@zipcode}&age=#{@age}"
	end

end

