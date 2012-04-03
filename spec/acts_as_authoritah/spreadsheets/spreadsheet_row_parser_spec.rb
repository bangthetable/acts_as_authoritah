require 'spec_helper'

describe ActsAsAuthoritah::SpreadsheetRowParser do
  before :each do 
    @valid_row = ["scope1::scope2", "Dummy", "edit", "test", "x", "X", nil]  
  end
  
  it "should take a valid row and return the scope" do
    ActsAsAuthoritah::SpreadsheetRowParser.new(@valid_row).scope.should eq "scope1::scope2"
  end
  
  it "should take a valid row and return the controller" do
    ActsAsAuthoritah::SpreadsheetRowParser.new(@valid_row).controller.should eq "Dummy"
  end
  
  it "should take a valid row and return the action" do
    ActsAsAuthoritah::SpreadsheetRowParser.new(@valid_row).action.should eq "edit"
  end
  
  it "should take a valid row and return the access rights" do
    ActsAsAuthoritah::SpreadsheetRowParser.new(@valid_row).access_rights.should eq [true, true, false]
  end

end