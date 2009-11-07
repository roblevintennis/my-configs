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

and sometimes had to use the error messages to install other dependent gems (i.e. cucumber needed treetop, etc.).

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
    

Mimicking the (Hellesoy) Adder example
------------
Now that I had the template, I basically renamed everything (file names and text IN the files from template to adder. Then I updated my adder.feature to look like:

    Feature:
    In order to Add
    As a complete imbecile 
    I want to see the sum of two numbers 

    Scenario: Add two numbers 
	Given I enter 20 in to the adder
	And I enter 30 in to the adder
	When I press add 
	Then the result should be 50 on the screen

And got the following output:
![First Run - No Pass](http://github.com/roblevintennis/my-configs/blob/master/cucumber/adder_1_no_pass.png "Running cucumber features/ - No Pass")

<img src="http://github.com/roblevintennis/my-configs/blob/master/cucumber/adder_1_no_pass.png" />

<img src="adder_1_no_pass.png" />
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

