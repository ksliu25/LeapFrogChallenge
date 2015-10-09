# LeapFrogChallenge
LeapFrog's code challenge

## Gems/packages
This makes use of the native net/http library along with native json library. For testing, http responses were stubbed using webmock.

## Testing
To test this challenge you will need to pulldown the repo and either bundle install or install the webmock gem manually.
<pre><code> bundle install </code></pre>
or
<pre><code>gem install webmock</code></pre>

Then simply run rspec spec in the root directory to run the tests. If the API endpoint times out, the library will make 3 attempts spaced 1 second apart to prevent excessive API hitting. I have had the misfortunate of not listening and angering Reddit's API...

##Usage of library

To actually use this library, just require the file directly and call the search method with a url to a specific API
<pre><code> LeapFrog.search("http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35") </code></pre>

For a successful API call, it will return the JSON object for further processing. You can also call 
<pre><code> LeapFrog.propensity("http://not_real.com/customer_scoring?income=50000&zipcode=60201&age=35") </code></pre>

to return the propensity of the specific JSON object should you know EXACTLY what will return.

In the case of failures the module will simply return a string specifying the failure of the API. However, for specific cases of shakey-interconnectivity, the library will attempt 3 times to reach the host.

##Usage of program

To use the program I chose to use a simple script. Simply run the script using runner code or replicate the method for use in a larger code base. 

