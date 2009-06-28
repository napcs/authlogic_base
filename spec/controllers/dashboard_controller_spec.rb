require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DashboardController do
integrate_views


  describe "shouble be authenticated" do
    it "should fail if we are not authenticated" do
      get :show
      response.should_not be_success
    end
  end


  describe "the show action" do
    before(:each) do
      activate_authlogic
      @user = Factory.create(:active_user)
      UserSession.create @user
      get :show
    end
    
    it "should find a user" do
      assigns(:user).should == @user
    end
    
    it "should render the show page" do
      response.should render_template("show")
    end
  
  end


end
