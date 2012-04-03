require 'spec_helper'

describe ActsAsAuthoritah::SpreadsheetReader do
  it "should be able to open a spreadsheet give a valid path" do
    ActsAsAuthoritah::SpreadsheetReader.new("spec/data/default.xls").valid?.should eq true
  end
  
  it "should be invalid if file not found" do
    ActsAsAuthoritah::SpreadsheetReader.new("spec/data/no_such_file.xls").valid?.should eq false
  end
  
  it "should return all valid rows (skip first row and other empty rows)" do
    reader = ActsAsAuthoritah::SpreadsheetReader.new("spec/data/default.xls")
    reader.valid_rows.count.should eq 2
  end
  
  it "should returns rows in the expected format" do
    reader = ActsAsAuthoritah::SpreadsheetReader.new("spec/data/default.xls")
    reader.valid_rows.should eq [
      ["scope1::scope2", "Dummy", "edit", "test", "x", nil, "x"], 
      ["scope3::scope4", "Another", "update", "test", nil, "x", "x"]
      ]
  end
  
  it "should return the header row" do
    reader = ActsAsAuthoritah::SpreadsheetReader.new("spec/data/default.xls")
    reader.header.should eq ["scope", "controller", "action", "description", "admin", "anonymous", "super_admin"]
  end
end