require 'spec_helper'

describe ActsAsAuthoritah::SpreadsheetWrapper do
  it "should be able to open a spreadsheet and convert to an array of AccessRules" do
    ActsAsAuthoritah::SpreadsheetWrapper.new("spec/data/default.xls").to_access_rules.first.class.should eq ActsAsAuthoritah::AccessRule
  end
end