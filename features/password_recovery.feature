Feature: Password recovery
As a forgetful user
I want to be able to recover my password
So that I can get back into the site when I lose my password!

Scenario: Recovering password
   Given I have signed up as a user
    When I go to the home page
     And I click "Recover your password"
     And I fill in "Email" with "user@example.com"
     And my email address is "user@example.com"
     And I press "Reset my password"
    Then I should receive an email
    When I open the email
     And I click the first link in the email
     And I fill in "Password" with "simpsonsrock!"
     And I fill in "Password Confirmation" with "simpsonsrock!"
     And I press "Update password"
    Then I should be on the dashboard page
     And I should see "Your password has been reset"