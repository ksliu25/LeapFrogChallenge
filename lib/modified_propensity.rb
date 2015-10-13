require_relative 'leap_library_api'

def modified_propensity(customer_hash_args)
	begin
		query = LeapFrog.new(customer_hash_args)
	rescue *ArgumentError => e
		return "You must provide a hash with income, zipcode, and age"
	end
	puts query.search["propensity"] + 2
end