Feature: Signing in
As an active user
I want to be able to log into my account
So that I can start using the site.

@selenium
Scenario: Home page login
Given I have signed up as a user
And I am on the home page
And I fill in "Login" with "user"
And I fill in "Password" with "password"
And I press "Log In"
And I should be on the dashboard page
