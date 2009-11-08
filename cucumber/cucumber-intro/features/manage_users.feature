Feature: Manage user
  In order to understand my user base better
  As an administrator
  I want to view a list of users

  Scenario: User list
    Given I have users named George, Mary
    When I go to the list of users
    Then I should see "George"
    And I should see "Mary"
