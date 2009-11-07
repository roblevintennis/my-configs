Feature: Hit Google via Webrat
    In order to confirm I have Webrat working properly
    As an imbecile programmer
    I want to hit Google Search and see something I expect

    Scenario: Search W3C and see www.w3.org/ on results page
	Given I have opened "http://www.google.com/"
	When I search for "World Wide Web Consortium"
	Then I should see a link to "http://www.w3.org/" with text "World Wide Web Consortium"
