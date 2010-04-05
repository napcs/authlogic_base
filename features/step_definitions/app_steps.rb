When /^(.*) for the (.*) whose (.*) is "(.*)"$/ do |step, class_name, var_name, text|
  within("tr:contains('#{text}')") do
    When step
  end
end