Feature: Manage users
As an administrator
I want to be able to add and edit users
So that people who don't have computers can still use the system.

Scenario: signup a user
Given I am logged in as an admin
And I click "Manage users"
And I click "New user"
 When I fill in "Login" with "homer"
 And I fill in "Email" with "homer@simpsons.com"
 And I fill in "Password" with "homer_rocks"
 And I fill in "Password Confirmation" with "homer_rocks"
 And I press "Create and activate this account"
 Then I should see "The account has been created and activated."
 
Scenario: edit an existing user

Given I am logged in as an admin
And a user is signed up
And I click "Manage users"
And I click "edit" for the User whose name is "user"
 And I fill in "Password" with "homer_rocks"
 And I fill in "Password Confirmation" with "homer_rocks"
 And I press "Edit this account"
 Then I should see "The account has been updated."

Scenario: Toggling Admin
Given I am logged in as an admin
And a user is signed up
And I click "Manage users"
And I click "Make Admin" for the User whose name is "user"
Then I should see "Remove Admin" for the User whose name is "user"
When I click "Remove Admin" for the User whose name is "user"
Then I should see "Make Admin" for the User whose name is "user"

 
