require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "value for username",
      :email => "value for email",
      :password => "value for password"
    }
  end

  describe "an existing user" do
    before(:each) do
      @user = Factory(:active_user)
    end
    
    it "should not require password to be passed in to update email" do
      @user.update_attributes(:email => "bart@bart.com").should == true
    end
    
    it "should be able to change his password" do
      @user.update_attributes(:password => "barney", :password_confirmation => "barney").should == true
    end
  
  end

  describe "should sign up a user" do
    before(:each) do
      Factory.create(:admin)
      
      @user = User.new
      params = {:user => {:login => "bphogan", :email => "foo@bar.com"}}
      @user.signup!(params).should == true
   
    end
    it "should set active to false" do
      @user.should_not be_active
    end
    
    it "should not be a mentor" do
      @user.should_not have_role("admin")
    end
    
    # it "should create a blank profile when created" do
    #   @user.activate!(:user => {:password => "homersimpson", :password_confirmation=>"homersimpson"})
    #   @user = User.find(@user.id)
    #   @user.profile.should_not be_nil
    # end
    
  end

  
  describe "roles" do
    it "should have the admin role" do
      u = Factory.create :active_user
      Factory.create(:admin_role)
      u.add_role "admin"
      u.should have_role("admin")
    end
    
    it "should not add a role twice" do
      u = Factory.create :active_user
      Factory.create(:admin_role)
      u.add_role "admin"
      u.add_role "admin"
      u.roles.length.should == 1
    end
    
  end


    it "should reset the token when sending activation instructions emails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.expects(:deliver_activation_instructions)
      old_token = user.perishable_token
      user.deliver_activation_instructions!
      user.perishable_token.should_not == old_token
    end
    
    it "should reset the token when sending activation confirmationemails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.expects(:deliver_activation_confirmation)
      old_token = user.perishable_token
      user.deliver_activation_confirmation!
      user.perishable_token.should_not == old_token
    end
    
    it "should reset the token when sending password reset instructions emails" do
      user = Factory.create(:user_waiting_activation)
      Notifier.expects(:deliver_password_reset_instructions)
      old_token = user.perishable_token
      user.deliver_password_reset_instructions!
      user.perishable_token.should_not == old_token
    end
    
end
