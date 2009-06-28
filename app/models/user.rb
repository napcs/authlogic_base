#=User
# A user can take on many roles depending on the circumstances.
#==Admin
# A user with the admin role is an admin and can approve MentorRequests.

class User < ActiveRecord::Base
  
  acts_as_authentic do |user_model|
    user_model.validates_length_of_password_field_options = {:minimum => 6, :on => :update, :if => :has_no_credentials? }
  end
  # implement if necessary
  #has_one :profile, :dependent => :destroy
  
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  
  #delegate :name, :to => :profile
  
  attr_accessible :login, :email, :password, :password_confirmation
  
  # returns true if the user has the "admin" role, false if not.
  def admin?
    has_role?("admin")
  end

  # returns true if the specified role is associated with the user.
  #  
  #  user.has_role("admin")
  def has_role?(role)
    self.roles.count(:conditions => ["name = ?", role]) > 0
  end
  
  # Adds a role to the user by name
  #
  # user.add_role("mentor")
  def add_role(role)
    return if self.has_role?(role)
    self.roles << Role.find_by_name(role)
  end
  
  # User creation/activation
  # Sets the login and email and then
  # creates the account in the database,
  # sending the activation.
  def signup!(params)
    self.login = params[:user][:login]
    self.email = params[:user][:email]
    save_without_session_maintenance
  end
  
  # Activates a user, sets their password, and 
  # creates a blank profile record associated
  # with the user.
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    #save_and_create_profile
    self.save
  end
  
   # an active account - passed activation  
   # Returns true if the user's active flag is set, false if not
   def active?
     active == true
   end
   
   # Returns true if the password field in the database is blank
   def has_no_credentials?
     self.crypted_password.blank?# && self.openid_identifier.blank?
   end

   # Email notifications
   
   # Resets the token and sends the password reset instructions via Notifier
   def deliver_password_reset_instructions!
     reset_perishable_token!
     Notifier.deliver_password_reset_instructions(self)
   end

   # Resets the token and sends the activation instructions via Notifier
   def deliver_activation_instructions!
     reset_perishable_token!
     Notifier.deliver_activation_instructions(self)
   end

   # Resets the token and sends the activation confirmatio via Notifier
   def deliver_activation_confirmation!
     reset_perishable_token!
     Notifier.deliver_activation_confirmation(self)
   end
  
   # Creates a blank profile, associates it with the user, 
   # and saves the user
   # def save_and_create_profile
   #   self.profile = Profile.new
   #   self.save
   # end
   
end
