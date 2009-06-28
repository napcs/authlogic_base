require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do
  integrate_views
   describe "When following the link in the email" do
     it "should display the new account activation page" do
       user = Factory.create(:user_waiting_activation)
       get :new, :activation_code => user.perishable_token
       response.should render_template("new")
     end
   end
   
   describe "when activating account with a password" do
     it "should go to the dashboard page" do
       user = Factory.create(:user_waiting_activation)
       post :create, :user => {:password => "homersimpson", :password_confirmation => "homersimpson"}, :id => user.id
       
       response.should redirect_to(dashboard_url)
     end
     
     it "should redisplay the form if they didn't enter the same password" do
       user = Factory.create(:user_waiting_activation)
       post :create, :user => {:password => "homersimpson", :password_confirmation => "homer"}, :id => user.id
       response.should render_template("new")
     end
   end
end
