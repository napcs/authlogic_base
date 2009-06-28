require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicPagesController do
  integrate_views
  #Delete these examples and add some real ones
  it "should use PublicPagesController" do
    controller.should be_an_instance_of(PublicPagesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should render_template("index")
    end
  end
  
end
