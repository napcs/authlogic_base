Webrat.configure do |config|
  config.mode = :selenium
  # Selenium defaults to using the selenium environment. Use the following to override this.
  config.application_environment = :test
end

# this is necessary to have webrat "wait_for" the response body to be available
# when writing steps that match against the response body returned by selenium
World(Webrat::Selenium::Matchers)

Before do
  tables = ActiveRecord::Base.connection.tables - ["schema_migrations", "schema_info"]
  tables.each do |table|
    table = table.camelize.singularize.constantize
    table.delete_all
  end
  
  Role.create :name => "admin"
  Role.create :name => "mentor"
end
