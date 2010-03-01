Webrat.configure do |config|
  config.mode = :selenium
  config.application_environment = :selenium
  config.application_framework = :rails
end
World(Webrat::Selenium::Matchers)

Cucumber::Rails::World.use_transactional_fixtures = false
require 'database_cleaner'
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation
Before do
  DatabaseCleaner.start
end
After do
  DatabaseCleaner.clean
end

# 
# module Webrat
#   class SeleniumSession
#     
#     ["click_link", "click_button"].each do |method|
#       class_eval <<-EOF
#         alias :old_#{method} :#{method}
#         def #{method}(*args)
#           old_#{method}(args)
#           warn "waiting for the page to load..."
#           selenium.wait_for_page_to_load
#         end
#       EOF
#     end
# 
#   end
#   
# end

