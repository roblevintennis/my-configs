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

and sometimes had to use the error messages to install other dependent gems (i.e. cucumber needed treetop, nokogiri, etc.).
<http://nokogiri.org/>
<http://treetop.rubyforge.org/>
 
I think for Ubuntu you may also need to get some other dependencies like:
    $ sudo aptitude install libxslt1-dev libxml2-dev

Cucumber Colors 
---------------
I used Aslak's highlight scheme from:
<http://wiki.github.com/aslakhellesoy/cucumber/console-colours><br />

'Aslak likes to highlight all parameters in magenta, so he uses this...' so I put this in my ~/.bash_profile:
    export CUCUMBER_COLORS=pending_param=magenta:failed_param=magenta:passed_param=magenta:skipped_param=magenta


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


Explicitly Getting Webrat in the Mix
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

And since I can't possibly think of a better way to put it, this is what we need to know about mechanize:
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
<a href="__http://www.w3.org/__" class="l"><em>World Wide Web Consortium</em>

So we probably forgot the http:// part. 
So we switch our google.feature's Then to read:
    Then I should see a link to "http://www.w3.org/" with text "World Wide Web Consortium"

We run our *cucumber features/* and get a pass! It looks like this:

<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_mechanize_google_pass_5.png" />

So there's Cucumber working in tangent with Webrat and mechanize to scrape Google! Again, thanks to James who posted what we've paraphrased here: <http://blog.jcoglan.com/2009/10/03/getting-started-with-cucumber-rspec-webrat-and-multiruby/>


------------
Jeweler
------------

__UPDATE!! ----- I just decided to create my own template instead__

Setting up a default project you can use: ** Jeweler ** to create a cucumber project:

### Using Jeweler to Create a Default Cucumber Project ###

Creating a default Cucumber project is easy:

    http://github.com/technicalpickles/jeweler
    sudo gem install jeweler
    git config --global github.user roblevintennis
    jeweler --cucumber --rspec name_of_project

This will create a boiler plate cucumber/gem document structure.

