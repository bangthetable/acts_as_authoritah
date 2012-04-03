require 'spec_helper'

describe ActsAsAuthoritah::SpreadsheetHeaderParser do
  it "should return the roles" do
    header_row = ["scope", "controller", "action", "description", "admin", "anonymous", "super_admin"]
    ActsAsAuthoritah::SpreadsheetHeaderParser.new(header_row).roles.should eq ["admin", "anonymous", "super_admin"]  
  end
end