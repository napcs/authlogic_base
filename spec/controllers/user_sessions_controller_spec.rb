require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
 integrate_views
 
 describe "the login page" do
   it "should render" do
     get "new"
     response.should render_template("new")
   end
 end
 
 describe "logging in" do
   it "should redirect to the dashboard when logged in" do
     @user = Factory.create(:active_user,
                            :password => "test",
                            :password_confirmation => "test",
                            :login => "homer")
     post :create, :user_session => {:login => "homer", :password => "test"}
     response.should redirect_to(dashboard_url)
   end
   
   it "should not let you in if you use the wrong password" do
     post :create
     response.should render_template("new")
   end
   
 end
 
 describe "logging out" do
   it "should return to the home page" do
     activate_authlogic
     @user = Factory.create(:active_user)
     UserSession.create @user
     delete :destroy
     response.should redirect_to(root_url)
     
   end
 end

end
