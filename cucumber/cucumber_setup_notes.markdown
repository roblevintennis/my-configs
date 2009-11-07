Download
--------

RSpec-Cucumber Setup -- November 4, 2009

I used the following guides:

<http://wiki.github.com/dchelimsky/rspec/code-for-the-rspec-book-beta><br />
<http://wiki.github.com/aslakhellesoy/cucumber/setting-up-selenium><br />
<http://seleniumhq.org/download/><br />

And basically had this configuration when I was done:
* rspec-1.2.9.rc1
* rspec-rails-1.2.9.rc1
* cucumber-0.3.11
* webrat-0.6.rc1
* rails-2.3.4
* Selenium-1.1.14
* selenium-client-1.2.16

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

'Aslak likes to highlight all parameters in magenta, so he uses this...'
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
*You on your own for renaming files and pointing everything to 'google' instead of 'template' -- I suggest you just cheat and copy the /google stuff instead ;-)*

I essentially set up the following feature and get the following output when I run: *cucumber feature/* for the google/ directory:
<img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_1.png" />










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

