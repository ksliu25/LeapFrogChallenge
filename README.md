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

To actually use this library, just require the file directly and instantiate a new class of LeapFrog with an argument hash of parameters. Since this is the direct library, there is no graceful failing or error catching for the initialization, that is handled by the program.
<pre><code> query = LeapFrog.new(:income => 50000, :zipcode => 60201, :age => 35) </code></pre>

For a successful API call, it will return the JSON object for further processing. To do this, call search on your LeapFrog instance
<pre><code> query.search #=> { "propensity": 0.26532, "ranking": "C" } </code></pre>

In the case of failures the class will simply return a string specifying the failure of the API. However, for specific cases of shakey-interconnectivity, the library will attempt 3 times to reach the host.

##Usage of program

To make use of the program, you MUST provide a hash argument. The program will provide some context should you fail to do this. Otherwise, it will print out the propensity to standard output.

<pre><code> modified_propensity(:income => 50000, :zipcode => 60201, :age => 35) #=> 2.26532 </code></pre>

With a key missing: 

<pre><code> modified_propensity(:income => 50000, :zipcode => 60201) #=> "You must provide a hash with income, zipcode, and age! Error: 'key not found: :age'" </code></pre>

With an argument other than a hash:

<pre><code> modified_propensity(50000) #=> "You must provide a hash with income, zipcode, and age! Error: 'undefined method `fetch' for 50000:Fixnum'" </code></pre>
