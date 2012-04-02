require 'spec_helper'

describe ActsAsAuthoritah::AccessControlList do
  context "store" do
    it "should build list" do
      rule1 = ActsAsAuthoritah::AccessRule.new("Admin::Projects", "Surveys","update",{:admin => true, :anonymous => false})
      rule2 = ActsAsAuthoritah::AccessRule.new("Admin::Users", "Configurations","edit",{:admin => true, :anonymous => false})
      
      ActsAsAuthoritah::AccessControlList.new([rule1, rule2]).store == rule1.to_rule.merge(rule2.to_rule)
    end
  end
end