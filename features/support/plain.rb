tables = ActiveRecord::Base.connection.tables - ["schema_migrations", "schema_info"]
tables.each do |table|
  table = table.camelize.singularize.constantize
  table.delete_all
end

Cucumber::Rails.use_transactional_fixtures
Cucumber::Rails.bypass_rescue # Comment out this line if you want Rails own error handling 
                              # (e.g. rescue_action_in_public / rescue_responses / rescue_from)

Webrat.configure do |config|
  config.mode = :rails
end


Before do
  Role.create :name => "admin"
  Role.create :name => "mentor"
end