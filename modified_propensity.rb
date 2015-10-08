require_relative 'leap_library_api'

def modified_propensity(url)
	LeapFrog.propensity(url) + 2
end