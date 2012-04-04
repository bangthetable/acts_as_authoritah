require 'spec_helper'

describe ActsAsAuthoritah::SpreadsheetWrapper do
  it "should be able to open a spreadsheet and convert to an array of AccessRules" do
    ActsAsAuthoritah::SpreadsheetWrapper.new("spec/data/default.xls").to_access_rules.first.class.should eq ActsAsAuthoritah::AccessRule
  end
  
  it "should load the spreadsheet to ACL correctly" do
    access_rules = ActsAsAuthoritah::SpreadsheetWrapper.new("spec/data/default.xls").to_access_rules
    ActsAsAuthoritah::AccessControlList.new(access_rules).store.should eq({
      "scope1::scope2::DummyController#edit"=>{"admin"=>true, "anonymous"=>false, "super_admin"=>true}, 
      "scope3::scope4::AnotherController#update"=>{"admin"=>false, "anonymous"=>true, "super_admin"=>true}
      })
  end
end