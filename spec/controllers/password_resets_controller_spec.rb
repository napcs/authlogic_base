require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do
 integrate_views
 describe "get /new" do
   it "should show the form" do
     get :new
     response.should render_template("new")
   end
 end
 
 describe "creating a password_request" do
   before(:each) do
     @user = Factory(:active_user)
   end
   
   it "should send the password reset message" do
     Notifier.expects(:deliver_password_reset_instructions)
     post :create, :email => @user.email
   end
   
   it "should redirect to the homepage" do
     post :create, :email => @user.email
     response.should redirect_to(root_url)
   end
   
   it "should send them back to the new form when they use a bad email" do
     post :create, :email => "nobody@nobody.com"
     response.should render_template("new")
   end
   
 end
 
 
 describe "get /edit" do
   it "should not show this without a token" do
     lambda {  
       get :edit
     }.should raise_error(ActionController::RoutingError)
   end
   
   it "should not show this page for a user with a regular id as it's unprotected" do
     user = Factory(:active_user)
     get :edit, :id => user.id
     response.should_not be_success
   
   end
   
   it "should display for a user requesting password" do
     user = Factory(:user_requesting_password)
     get :edit, :id => user.perishable_token
     response.should be_success
     response.should render_template("edit")
   end
  
 end
 
 describe "PUT /update" do
   it "should reset the password with good info" do
     user = Factory(:user_requesting_password)
     User.any_instance.stubs(:save).returns(true)
     put :update, {:id=>user.perishable_token, 
                   :user => {
                     :password => 'changedpassword!',
                     :password_confirmation => "changedpassword!"
                     }
                 }
     response.should redirect_to(dashboard_url)
    
   end
   

   
   it "should not reset the password with bad info" do
     user = Factory(:user_requesting_password)
     User.any_instance.stubs(:save).returns(false)
     put :update, {:id=>user.perishable_token, 
                   :user => {
                     :password => 'changedpassworsd!',
                     :password_confirmation => "changedpassword!"
                     }
                 }
     response.should render_template("edit")
   end
 end
end
