puts "Adding roles for tests..."
Before do
  Role.create :name => "admin"
  Role.create :name => "user"
end