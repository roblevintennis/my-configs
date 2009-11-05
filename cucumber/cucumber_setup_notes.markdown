Download
--------

RSpec-Cucumber Setup -- November 4, 2009

<http://wiki.github.com/dchelimsky/rspec/code-for-the-rspec-book-beta><br />
<http://wiki.github.com/aslakhellesoy/cucumber/setting-up-selenium><br />
<http://seleniumhq.org/download/><br />


Introduction
------------
Use the /template directory as a starting point then run:
    cucumber features/

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
    


------------
Jeweler
------------

UPDATE!! ----- I just decided to create my own template instead

Setting up a default project you can use: ** Jeweler ** to create a cucumber project:

### Using Jeweler to Create a Default Cucumber Project ###

Creating a default Cucumber project is easy:

    http://github.com/technicalpickles/jeweler
    sudo gem install jeweler
    git config --global github.user roblevintennis
    jeweler --cucumber --rspec name_of_project

This will create a boiler plate cucumber/gem document structure.

