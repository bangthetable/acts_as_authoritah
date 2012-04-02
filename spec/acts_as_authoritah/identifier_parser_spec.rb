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
  
  # context "controller" do
  #     it "should return nil if identifier is empty" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should be_nil
  #     end
  #     
  #     it "should return nil if identifier is nil" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new(nil, "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should be_nil
  #     end
  #   
  #     it "should return controller name if only controller is present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should eq "BlogPosts"
  #     end
  #     
  #     it "should return controller name if controller and action are present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should eq "BlogPosts"
  #     end
  #     
  #     it "should return controller name if controller, one level scope and action are present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should eq "Projects::BlogPosts"
  #     end
  #     
  #     it "should return controller name if controller, two level scopes and action are present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Admin::Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should eq "Admin::Projects::BlogPosts"
  #     end
  #   
  #     it "should return controller name if controller and '#' are present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts#", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.controller.should eq "BlogPosts"
  #     end
  #   end
  #   
  #   context "scopes" do
  #     it "should return nil if identifier is empty" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.scopes.should eq []
  #     end
  #     
  #     it "should return nil if identifier is nil" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new(nil, "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.scopes.should eq []
  #     end
  #   
  #     it "should return [] if only controller is present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.scopes.should eq []
  #     end
  #     
  #     it "should return scope array if controller and level one scope is present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Projects::BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.scopes.should eq ["Projects"]
  #     end
  #     
  #     it "should return scope array if controller and level two scope is present" do
  #       identifier_parser = ActsAsAuthoritah::IdentifierParser.new("Admin::Projects::BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
  #       identifier_parser.scopes.should eq ["Admin","Projects"]
  #     end
  #   end
  
end