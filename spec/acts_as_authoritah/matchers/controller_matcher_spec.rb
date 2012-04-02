require 'spec_helper'

describe ActsAsAuthoritah::Matchers::ControllerMatcher do
  before :each do
    @store = {
      "Admin::Projects::ForumsController#index" => "abc", 
      "Admin::Projects" => "abc", 
      "BlogsController" => "abc", 
      "Admin" => "abc" 
    }
  end
  
  it "should return nil if controller din't match" do
    ActsAsAuthoritah::Matchers::ControllerMatcher.new(@store).match("ForumsController#index").should be_nil
  end  

  it "should match the controller and return the result" do
    ActsAsAuthoritah::Matchers::ControllerMatcher.new(@store).match("BlogsController#index").should eq "abc"
  end
end