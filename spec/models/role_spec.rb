require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  it "should be invalid without a name" do
    role = Role.new
    role.valid?
    role.errors.on(:name).should include("can't be blank")
  end
end
