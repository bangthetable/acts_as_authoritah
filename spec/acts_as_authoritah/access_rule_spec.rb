require 'spec_helper'

describe ActsAsAuthoritah::AccessRule do
  context "after setup" do
    before :each do
      @access_rule = ActsAsAuthoritah::AccessRule.new("Admin::Projects","Surveys","edit",{:admin => true, :anonymous => false})
    end
  
    it "should be able to build a new access rule and return its scope" do
      @access_rule.scope.should eq "Admin::Projects"
    end
  
    it "should be able to build a new access rule and return its controller" do
      @access_rule.controller.should eq "Surveys"
    end
    
    it "should be able to build a new access rule and return its action" do
      @access_rule.action.should eq "edit"
    end
  
    it "should be able to build a new access rule and return its access-rights" do
      @access_rule.access_rights.should eq({:admin => true, :anonymous => false})
    end
  end
  
  context "generate rule" do
    it "should generate a valid rule: case1" do
      access_rule = ActsAsAuthoritah::AccessRule.new("Admin::Projects", "BlogPosts", "create", {:admin => true, :anonymous => false})
      access_rule.to_rule.should eq({"Admin::Projects::BlogPostsController#create" => {:admin => true, :anonymous => false}})
    end
    
    it "should generate a valid rule: case2" do
      access_rule = ActsAsAuthoritah::AccessRule.new("", "Projects", nil, "f")
      access_rule.to_rule.should eq({"ProjectsController" => "f"})
    end

  end

end