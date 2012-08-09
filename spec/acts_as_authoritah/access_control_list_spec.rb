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

    it "test8" do
      @acl.match("Admin::ProjectsController#create").should eq "a"
    end

  end

  context "match_identifier" do
    before :each do
      rules = [
        ActsAsAuthoritah::AccessRule.new("Admin", nil, nil, "c"),
      ]

      @acl = ActsAsAuthoritah::AccessControlList.new(rules)
    end

    it "should return {} if there is no match" do
      @acl.match_identifier("LinksController#create").should eq({})
    end

    it "should return the matched value if there is a match" do
      @acl.match_identifier("Admin::ProjectsController#create").should eq "c"
    end
  end

  context "merge" do
    before :each do
      rules = [
        ActsAsAuthoritah::AccessRule.new("Admin", nil, nil, "c"),
        ActsAsAuthoritah::AccessRule.new("Admin", "Projects", nil, "d"),
      ]
      @acl1 = ActsAsAuthoritah::AccessControlList.new(rules)

      rules = [
        ActsAsAuthoritah::AccessRule.new("Admin", nil, nil, "C")
      ]
      @acl2 = ActsAsAuthoritah::AccessControlList.new(rules)
    end

    it "should merge two @acl2 into @acl1 overriding common rule using the one from @acl2" do
      @acl1.store.should eq({"Admin"=>"c", "Admin::ProjectsController"=>"d"})
      @acl2.store.should eq({"Admin"=>"C"})

      new_acl = @acl1.merge(@acl2)

      new_acl.store.should eq({"Admin"=>"C", "Admin::ProjectsController"=>"d"})
      @acl1.store.should eq({"Admin"=>"c", "Admin::ProjectsController"=>"d"})
      @acl2.store.should eq({"Admin"=>"C"})
    end
  end
end
