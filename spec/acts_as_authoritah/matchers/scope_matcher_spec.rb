require 'spec_helper'

describe ActsAsAuthoritah::Matchers::ScopeMatcher do
  before :each do
    @store = {
      "Admin::Projects::ForumsController#index" => "abc", 
      "Admin::Projects" => "xyz", 
      "BlogsController" => "abc", 
      "Admin" => "abc" 
    }
  end
  
  it "should return nil if scope din't match" do
    ActsAsAuthoritah::Matchers::ScopeMatcher.new(@store).match("Forums").should be_nil
  end  

  it "should match the second level scope and return the result" do
    ActsAsAuthoritah::Matchers::ScopeMatcher.new(@store).match("Admin::Projects::BlogsController#index").should eq "xyz"
  end
  
  it "should match the first level scope and return the result" do
    ActsAsAuthoritah::Matchers::ScopeMatcher.new(@store).match("Admin::Surveys::BlogsController#index").should eq "abc"
  end

end