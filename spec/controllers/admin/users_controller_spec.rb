require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do
integrate_views

  describe "when logged in as admin" do
    
    before(:each) do
      activate_authlogic
      @user = Factory.create(:active_user, :login => "fred", :email=>"fred@foo.com")
      @inactive_user = Factory.create(:user)
      @admin  = Factory.create(:admin)
      UserSession.create @admin
    end
    
    
    describe "the index page" do
      it "should render index view" do
        get :index
        response.should render_template(:index)
      end
      
      it "should find all active users" do
        get :index
        assigns(:users).should_not include(@inactive_user)
        assigns(:users).should include(@admin)
        assigns(:users).should include(@user)
      end
      
      
    end
    
    
    describe "when creating - POST /create" do

      it "should go to users list when successfully created" do
        post :create, :user=>{:login => "newuser", :email => "new@new.com"}
        response.should redirect_to(admin_users_url)
      end
      
      it "should have created an active user" do
        post :create, :user=>{:login => "newuser", :email => "new@new.com"}
        u = assigns(:user).reload
        u.should be_active
      end

      it "should redisplay the new page if nothing passed" do
        post :create, :user=>{:email => "new@new.com"}
        response.should render_template("new")
      end

    end
    
    describe "when showing" do
      it "should find the right user" do
        get :show, :id => @user.id
        assigns(:user).should == @user
      end
      
      it "should show the show page" do
        get :show, :id => @user.id
        response.should render_template("show")
      end
      
    end
    
    describe "when editing" do
      it "should find the right user" do
        get :edit, :id => @user.id
        assigns(:user).should == @user
      end
      
      it "should show the show page" do
        get :edit, :id => @user.id
        response.should render_template("edit")
      end
      
    end
    
    
    describe "when updating" do
      
      it "should find the right user" do
        put :update, :id => @user.id
        assigns(:user).should == @user
      end
      
      it "should go back to the users list after a successful update" do
        u = Factory.create(:active_user, :email => "testing@tester.com", :login => "testinguser")
        u.stubs(:update).returns(true)
        put :update, :id => @user.id
        response.should redirect_to(admin_users_path)
      end
      
      it "should go back to the edit page after a bad update" do
        User.any_instance.expects(:update_attributes).returns(false)
        put :update, :id => @user.id
        response.should render_template("edit")
      end



    end
    
    
    
  end



end
