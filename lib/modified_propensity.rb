require_relative 'leap_library_api'

def modified_propensity(url)
	puts url.is_a?(Fixnum) ? LeapFrog.propensity(url) + 2 : LeapFrog.propensity(url)
end