Download
--------

RSpec-Cucumber Setup -- November 4, 2009

I used the following guides:

<http://wiki.github.com/dchelimsky/rspec/code-for-the-rspec-book-beta><br />
<http://wiki.github.com/aslakhellesoy/cucumber/setting-up-selenium><br />
<http://seleniumhq.org/download/><br />

And basically had this configuration when I was done:
*   rspec-1.2.9.rc1
*   rspec-rails-1.2.9.rc1
*   cucumber-0.3.11
*   webrat-0.6.rc1
*   rails-2.3.4
*   Selenium-1.1.14
*   selenium-client-1.2.16
*   mechanize-0.9.3

I basically went down the list doing:

    sudo gem install WHATEVER

and sometimes had to use the error messages to install other dependent gems (i.e. cucumber needed treetop, nokogiri, etc., which you can also install as gems).<br />
For more info on these:
<http://nokogiri.org/><br .?
<http://treetop.rubyforge.org/>


__UPDATE__ For the error that libxml2 gives like *I_KNOW_I_AM_USING_AN_OLD_AND_BUGGY_VERSION_OF_LIBXML2 before requring nokogiri...* see the following but first try (requires macports):
    sudo port install libxml2 libxslt 
    sudo gem install nokogiri -- --with-xml2-include=/opt/local/include/libxml2 --with-xml2-lib=/opt/local/lib --with-xslt-dir=/opt/local

*This essentially reinstalls the nokogiri after we've reinstalled updated libxml2* See more:
<http://wiki.github.com/tenderlove/nokogiri/what-to-do-if-libxml2-is-being-a-jerk>

__Ubuntu__
I think for Ubuntu you may also need to get some other dependencies like (but I did mine on mac):
    $ sudo aptitude install libxslt1-dev libxml2-dev

Cucumber Colors 
---------------
I used Aslak's highlight scheme from:
<http://wiki.github.com/aslakhellesoy/cucumber/console-colours><br />

'Aslak likes to highlight all parameters in magenta, so he uses this...' so I put this in my ~/.bash_profile:
    export CUCUMBER_COLORS=pending_param=magenta:failed_param=magenta:passed_param=magenta:skipped_param=magenta


Introduction 
------------
The reason I wrote this is that I like to catalog these types of things for later reference, and also so someone else can have another place to reference. That being said, it's impossible to do it in perfect cookbook style so you may be on your on at times :-(

It seems that the suggested ramp up route is to read the RSpec book and/or watch the Ryan Bates railscast. The github readme's are also helpful for webrat/rspec, etc. However, I found that starting as simply as possible (like what sort of directory structure do I need to create and should I use a generator or mkdir/touch???), was very helpful. I think a reader of this tut will save a LOT of time as I sort of plodded through it!

Running the Cucumber Template
------------
Use the /template directory as a starting point then run:
    
    $ cucumber features/

      Feature:
        In order to understand Cucumber
        As a frustrated programmer
        I want to get the damn test to pass

      Scenario: Pass already                 # features/template.feature:6
        Given I think I know what I am doing # features/template.feature:7
        When I run this test                 # features/template.feature:8
        Then it will pass                    # features/template.feature:9

    1 scenario (1 undefined)
    3 steps (3 undefined)
    0m0.003s

    You can implement step definitions for undefined steps with these snippets:

    Given /^I think I know what I am doing$/ do
      pending
    end

    When /^I run this test$/ do
      pending
    end

    Then /^it will pass$/ do
      pending
    end
    

Mimicking the (Hellesoy) Adder example (step by step!)
------------
Now that I had the template, I basically renamed everything (file names and text IN the files from template to adder. Then I updated my adder.feature as you can see in the following output as I've stacked the test and the ouput after running 'cucumber features' respectively:

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_1_no_pass.png" />
 
Given that the output gives some suggestions on what we can use for our step definition for the 'Given' we cut and past but change the definition to use a block and then we run our cucumber features again:

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_2_first_step_def.png" />

The first is yellow indicating the that step is still pending; the blue steps show that cucumber has essentialy skipped these. So we need to create our Adder object and push each operand:

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_3_no_Adder.png" />

But there is no Adder object! In fact, if we somehow don't know what's wrong intuitively, Cucumber tells us: see the line in red that says: 'uninitialized constant Adder (NameError)' -- this is basically Cucumber telling us what to do next 'Go create an Adder!'. So we implement the Adder class (note that we already have the ruby file in /lib/adder.rb but it's empty so we do:

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_4_2_passing.png" />

Woohoo! We have half our scenario passing: _4 steps (2 undefined, 2 passed)_ But there's a problem next when we try to work on the When step because our Adder object has went out of scope so we can't tell it to add the two operands we've "pushed". We need an object that will "stick around" between the Given|When|Then, so we use a typical TDD hook 'Before' and get the next pass"

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_5_before_hook.png" />

And finally we add our 'Then' step definition and simply make sure that our results match up:

<img src="/roblevintennis/my-configs/raw/master/cucumber/adder_6_pass.png" />

And we've methodically finished a Scenario for the Addition feature!


Getting Webrat in the Mix (oh yeah, we need mechanize too!)
------------------------------------
Referenced: <http://blog.jcoglan.com/2009/10/03/getting-started-with-cucumber-rspec-webrat-and-multiruby/>

_Just want to actually use Webrat to do something like 'visit' such and such url, etc._

First I copied over my template like so (and then rename as usual filenames and anything 'template' to 'google':
cp -r template/ google
*You on your own for renaming files and pointing everything to 'google' instead of 'template' -- I suggest you just cheat and copy my /cucumber/google stuff instead ;-)*

I essentially set up the following feature and get the following output when I run: *cucumber feature/* for the google/ directory:
<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_1.png" />
*above screen shot cut off the Feature in my Vim, but you see it in the output anyway ;-)*

So Cucumber gives us the customary iniital suggestions for our spec defs saying: *You can implement step definitions for undefined steps with these snippets:*
So we take the:
    Given /^I have opened "([^\"]*)"$/ do |arg1|
        pending
    end
*and modify it to:*
    Given /^I have opened "([^\"]*)"$/ do |url|
        visit url
    end
in our features/step_definitions/google_steps.rb file and get the following error:

<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_error_2.png" />
We apparently don't have a webrat handle so we have to include it? Also, googling around tells us that we can only test local web sites (i.e. a local rails app, etc.) with webrat - but with mechanize we *can* scrape outside sites:
    sudo gem install mechanize

mechanize
---------

And since I can't possibly think of a better way to put it, here's what James said in his blog about mechanize:
**The first step will be marked yellow to indicate that it’s pending, and the remaining steps will be blue to show they’ve been skipped. Let’s try to turn the first step green. In step_definitions/search_steps.rb, change the first definition to the following:

    Given /^I have opened "([^\"]*)"$/ do |url|
        visit url
    end

visit is a method provided by Webrat for getting web pages. We need to tell Cucumber to load Webrat and include its methods in the testing environment, which we do by putting this in support/env.rb:

    require 'webrat'

    Webrat.configure do |config|
        config.mode = :mechanize
    end

    World(Webrat::Methods)
    World(Webrat::Matchers)

Webrat doesn’t actually make requests itself, it provides adapters to other systems such as Rails and Sinatra for calling their web stacks with a uniform API. We just want to query the web, so we’re using telling Webrat to use Mechanize to fetch pages. We then mix two modules into the Cucumber World, the context that all your steps run in. Webrat::Methods provides methods like visit and click_button for navigating the web, and Webrat::Matchers provides things like have_selector and contains for use with RSpec’s should interface.
**

So after adding the above stuff we run our *cucumber features/* and get a boatload of output including some complaints that we're running an old buggy version of libxml2, and a nokigiri parenthesize warning...we choose to ignore both for now. The important part is that we've actually opened google.com!

<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_mechanize_google_opened_3.png" />

So this is our first sign of success -- now we want to actually fill in Google's all so powerful textfield and have our search term do the search. Using the Firebug Inspector, we click on the textfield and see:
<input value="" title="Google Search" class="lst" size="55" name="**q**" maxlength="2048" autocomplete="off"/>
Conveniently, webrat has a 'fill_in' which will allow us to enter the search term into Google's 'q' text field:

    When /^I search for "([^\"]*)"$/ do |term|
        fill_in "q", :with => term
        click_button "Google Search"
    end

We run cucumber again and, amongst other things, see:
<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_mechanize_google_search_4.png" />

2 passes! So we have to implement our last step definition:

Then /^I should see a link to "([^\"]*)" with text "([^\"]*)"$/ do |url, text|
  response_body.should have_selector("a[href='#{ url }']") do |element|
    element.should contain(text)
  end
end

We get a __huge__ red error with a dump of some of the html that got returned. Looking through it we notice in the anchor we were expecting:
<a href="__http://www.w3.org/__" class="l"><em>World Wide Web Consortium</em></a>

So we probably forgot the http:// part. 
So we switch our google.feature's Then to read:
    Then I should see a link to "http://www.w3.org/" with text "World Wide Web Consortium"

We run our *cucumber features/* and get a pass! It looks like this:

<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_mechanize_google_pass_5.png" />

So there's Cucumber working in tangent with Webrat and mechanize to scrape Google! Again, thanks to James who posted what we've paraphrased here: <http://blog.jcoglan.com/2009/10/03/getting-started-with-cucumber-rspec-webrat-and-multiruby/>
Also found another code example here (but did not try it as we got this one working):<http://github.com/cayblood/cucumber-webrat-mechanize-example>

mechanize
---------

_Being curious about mechanize, we put an example script from: <http://mechanize.rubyforge.org/mechanize/GUIDE_rdoc.html> in the /cucumber/mechanize_test directory which you should be able to run with: ruby mechanize_test.rb (if you're in the mechanize_test/ directory of course)_

Cucumber/Webrat with Rails 
--------------------------
IMO, it was good to use Cucumber outside of Rails, and sort of build on it layer by layer adding webrat, mechanize, etc. Now, we're probably ready to use it in Rails -- the best idea at this point is to head over to any and/or all of the following from Ryan Bates:<br />
<http://railscasts.com/episodes/155-beginning-with-cucumber><br />
<http://asciicasts.com/episodes/155-beginning-with-cucumber><br />
<http://github.com/ryanb/railscasts-episodes/tree/master/episode-155><br />

Also Ericy Berry made a tutorial here:<br />
<http://vimeo.com/6563331> or maybe: <http://www.teachmetocode.com/screencasts/4> This was helpful in that it showed how you start at the cucumber abstraction level, and then drill down into the rspec unit tests, and then come back up to cucumber. That being said, he (and I while I followed along) were using the system installed gems. This is fine, but I think RB's config.gem steps are a cleaner way to go.

_If you're a nut like me, you catalog select parts of your shell history ;-)_
    rails cucumber-intro
    cd cucumber-intro/
    ./script/generate cucumber
    ./script/generate rspec
    rm -rf test
    rake db:schema:dump
    vim &
    cucumber features/manage_users.feature 
    script/generate rspec_model user name:string
    rake db:migrate
    rake db:test:clone
    rake spec
    spec spec/models/user_spec.rb 
    cucumber features/manage_users.feature 
    open .
    ./script/generate rspec_controller users
    spec spec/controllers/users_controller_spec.rb 
    cucumber features/manage_users.feature 
    sudo port install libxml2 libxslt 
    sudo gem install nokogiri -- --with-xml2-include=/opt/local/include/libxml2 --with-xml2-lib=/opt/local/lib --with-xslt-dir=/opt/local  
    cucumber features/manage_users.feature 

------------
Seeding Data
------------
Put script in db/seeds.rb and then run:
    rake db:seed RAILS_ENV=test
    rake db:test:clone
    cucumber features/

------------
Jeweler
------------

This is a tools like gemcutter for creating your own gems and does some nice generator stuff. It also takes options for rpec and cucumber, so now that we now how to use those, we can get really fancy and make our own stuff:

### Using Jeweler to Create a Default Cucumber Project ###

Creating a default Cucumber project is easy:

    http://github.com/technicalpickles/jeweler
    sudo gem install jeweler
    git config --global github.user roblevintennis
    jeweler --cucumber --rspec name_of_project

This will create a boiler plate cucumber/gem document structure.


