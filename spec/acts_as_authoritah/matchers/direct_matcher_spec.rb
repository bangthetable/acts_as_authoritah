require 'spec_helper'

describe ActsAsAuthoritah::Matchers::DirectMatcher do
  before :each do
     @store = {
        "Admin::Projects::BlogsController#index" => "abc", 
        "Admin::Projects" => "abc", 
        "Admin::Projects::BlogsController" => "abc", 
        "Admin" => "abc" 
    }
  end

  it "should return nil if identifier din't match" do
    ActsAsAuthoritah::Matchers::DirectMatcher.new(@store).match("ProjectsController#home").should be_nil
  end  

  it "should match the identifier and return the result" do
    ActsAsAuthoritah::Matchers::DirectMatcher.new(@store).match("Admin::Projects::BlogsController#index").should eq "abc"
  end
end