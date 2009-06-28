require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "email_spec/helpers"
require "email_spec/matchers"

describe Notifier do
   include EmailSpec::Helpers
   include EmailSpec::Matchers
   
  it "should send the activation message" do
    user = Factory.create(:user_waiting_activation)
    @email = Notifier.create_activation_instructions(user)
    @email.should deliver_to(user.email)
  end
  
  it "should send the password_reset message" do
    user = Factory.create(:user_requesting_password)
    @email = Notifier.create_password_reset_instructions(user)
    @email.should deliver_to(user.email)
  end
  
  it "should send the activation confirmation message" do
    user = Factory.create(:active_user)
    @email = Notifier.create_activation_confirmation(user)
    @email.should deliver_to(user.email)
  end
 
  
  
end
