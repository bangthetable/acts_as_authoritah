require 'spec_helper'

describe ActsAsAuthoritah::AccessControlList do
  context "store" do
    it "should build list" do
      rule1 = ActsAsAuthoritah::AccessRule.new("Admin::Projects", "Surveys","update",{:admin => true, :anonymous => false})
      rule2 = ActsAsAuthoritah::AccessRule.new("Admin::Users", "Configurations","edit",{:admin => true, :anonymous => false})
      
      ActsAsAuthoritah::AccessControlList.new([rule1, rule2]).store.should eq rule1.to_rule.merge(rule2.to_rule)
    end
  end
  
  context "match" do
    before :each do
      rules = [
        ActsAsAuthoritah::AccessRule.new("Admin", nil, nil, "a"),
        ActsAsAuthoritah::AccessRule.new("Projects", "Surveys","edit", "b"),
        ActsAsAuthoritah::AccessRule.new("Admin::Projects", nil, nil, "c"),
        ActsAsAuthoritah::AccessRule.new("Admin::Projects", "Surveys", nil, "d"),
        ActsAsAuthoritah::AccessRule.new("Projects", "Surveys", "update", "e"),
        ActsAsAuthoritah::AccessRule.new("", "Projects", nil, "f")
      ]
      
      @acl = ActsAsAuthoritah::AccessControlList.new(rules)
    end
    
    it "test1" do
      @acl.match("Admin::ForumsController#index").should eq "a"
    end
    
    it "test2" do
      @acl.match("Admin::Projects::SurveysController#index").should eq "d"
    end
    
    it "test3" do
      @acl.match("Projects::SurveysController#index").should eq nil
    end
    
    it "test4" do
      @acl.match("Projects::SurveysController#update").should eq "e"
    end

    it "test5" do
      @acl.match("Projects::SurveysController#edit").should eq "b"
    end
  
    it "test6" do
      @acl.match("Admin::Projects::HomeController#update").should eq "c"
    end
    
    it "test7" do
      @acl.match("ProjectsController#create").should eq "f"
    end

    
  end
end