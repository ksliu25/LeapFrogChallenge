require_relative 'leap_library_api'

def modified_propensity(customer_hash_args)
	begin
		query = LeapFrog.new(customer_hash_args)
	rescue KeyError, ArgumentError, NoMethodError => e
		return "You must provide a hash with income, zipcode, and age! Error: '#{e}'"
	end
	puts (query.search).is_a?(Hash) ? query.search["propensity"] + 2 : query.search
end