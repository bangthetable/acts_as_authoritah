require 'spec_helper'

describe ActsAsAuthoritah::IdentifierParser do
  
  context "action" do
    it "should return nil if identifier is empty" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("")
      identifier_parser.action.should be_nil
    end
    
    it "should return nil if identifier is nil" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new(nil)
      identifier_parser.action.should be_nil
    end
  
    it "should return nil if only controller name is present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts")
      identifier_parser.action.should be_nil
    end
    
    it "should return nil if only controller name and scope is present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Admin::BlogPosts")
      identifier_parser.action.should be_nil
    end
  
    it "should return nil if only controller name and '#' is present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Admin::BlogPosts#")
      identifier_parser.action.should be_nil
    end
  
    it "should return action name when controller and action are present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts#edit")
      identifier_parser.action.should eq "edit"
    end
    
    it "should return action name when controller, one level scope and action are present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Projects::BlogPosts#edit")
      identifier_parser.action.should eq "edit"
    end
    
    it "should return action name when controller, two level scopes and action are present" do
      identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Admin::Projects::BlogPosts#edit")
      identifier_parser.action.should eq "edit"
    end
  end
  
end