Feature: Login

  Scenario: Login
      Given a user with username test and password test
      And I am on the login page
      And I fill in "test" for "username"
      And I fill in "test" for "password"

      Then I should be on the home page


  