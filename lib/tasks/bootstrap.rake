namespace :db do
  task :bootstrap do
    Rake::Task["db:schema:load"].invoke
    Rake::Task["environment"].invoke
    
    Rake::Task["db:add_roles"].invoke
    
    puts "Creating admin account"
    puts "---------------------"
    admin_user = ask("Admin username: ")
    admin_email = ask("Admin email: ")
    admin_pass = ask("Admin password: ")
    puts "creating account..."
    
    u = User.new(:login => admin_user, :password => admin_pass, :password_confirmation => admin_pass, :email => admin_email)
    u.active = true
    
    if u.save
      u.add_role("admin")
      puts "Done!"
    else
      puts "User was not created."
    end
        

    
  end
  
  task :add_roles => :environment do
    ["admin","user"].each do |role|
      puts "Adding '#{role}'"
      Role.find_or_create_by_name(role)
    end
  end
  
end

def ask message
   print message
   STDIN.gets.chomp
end