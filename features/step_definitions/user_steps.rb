When /^I click "([^\"]*)"$/ do |link|
  click_link(link)
end


Given /^(they|I) log out$/ do |user|
  visit "/logout"
end

# look at the factories. The role == the username to make this easier to follow
Given /^a (.*) is logged in$/  do |role|
  Given 'a ' + role + ' is signed up'
    And 'I go to the home page'
    And 'I fill in "Login" with "' + role + '"'
    And 'I fill in "Password" with "password"'
    And 'I press "Log In"'
end

Given /^a (.*) is signed up/ do |role|
  type = get_type(role)
  @signed_up_user = Factory.create(type)
end

Given /^I am logged in as an (.*)/ do |role|
  Given 'I am logged in as a ' + role
end


# look at the factories. The role == the username to make this easier to follow
Given /^I am logged in as a (.*)/ do |role|
  Given 'I have signed up as a ' + role
    And 'I go to the home page'
    And 'I fill in "Login" with "' + role + '"'
    And 'I fill in "Password" with "password"'
    And 'I press "Log In"'
    Then 'I should see "Login successful!"'
end

Given /^I have signed up as a (.*)$/ do |role| 
  type = get_type(role)
  user = Factory.build(type)
  if user.save
    @current_user = user
  else
    @current_user = User.find_by_login(user.login)
    raise "problem with saving or locating a user from the factory. Check validations and flows." if @current_user.nil?
  end
end

def get_type(role)
  type = case role.strip
       when "user"
         :active_user
       when "admin"
         :admin
       when "organizer"
         :organizer
       when "merchant"
         :merchant
       end 
  type
end
