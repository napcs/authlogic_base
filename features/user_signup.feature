Feature: User Signup
  In order to use Social Brokerage
  As an interested organizer or merchant
  I want to sign up
  
Scenario: Signing up to use the system
  Given I go to the home page
    And I click "Sign up"
    And I fill in "Login" with "homer"
    And I fill in "Email" with "homer@simpsons.com"
    And I press "Sign Up"
   Then I should receive an email
   When I open the email
   Then I should see "Please activate your YOUR_APP account" in the subject
   When I click the first link in the email
   Then I should see "Almost done..."
   When I fill in "Password" with "homer_rocks"
    And I fill in "Password Confirmation" with "homer_rocks"
    And I press "Start using your account!"
   Then I should be on the dashboard page
    And I should see "Your account has been activated"

    Scenario: Checking the password confirmation
    Given I go to the home page
      And I click "Sign up"
      And I fill in "Login" with "homer"
      And I fill in "Email" with "homer@simpsons.com"
      And I press "Sign Up"
     Then I should receive an email
     When I open the email
     Then I should see "Please activate your YOUR_APP account" in the subject
     When I click the first link in the email
     Then I should see "Almost done..."
     When I fill in "Password" with "homer_rocks"
      And I fill in "Password Confirmation" with "xhomer_rocks"
      And I press "Start using your account!"
      And I should see "Password doesn't match confirmation"

  Scenario: Check for too short email address during signup
    Given I go to the home page
      And I click "Sign up"
      And I fill in "Login" with "homer"
      And I press "Sign Up"
      Then I should see "Email is too short (minimum is 6 characters)"
 
  Scenario: Check for invalid email address during signup
    Given I go to the home page
      And I click "Sign up"
      And I fill in "Login" with "homer"
      And I fill in "Email" with "homer-simpsons.com"
      And I press "Sign Up"
      Then I should see "Email should look like an email address"
     
