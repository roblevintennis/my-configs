Feature: Addition
    In order to Add
    As a complete imbecile 
    I want to see the sum of two numbers 

    Scenario: Add two numbers 
	Given I enter 20 in to the adder
	And I enter 30 in to the adder
	When I press add 
	Then the result should be 50 on the screen	
