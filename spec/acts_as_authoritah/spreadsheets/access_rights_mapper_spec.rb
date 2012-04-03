require 'spec_helper'

describe ActsAsAuthoritah::AccessRightsMapper do
  it "should take roles and access rights and map them correctly" do
    roles = ["admin", "super_admin", "anonymous"]
    access_rights = [true, true, false]
    ActsAsAuthoritah::AccessRightsMapper.new(roles, access_rights).map.should eq({
      "admin"       => true,
      "super_admin" => true,
      "anonymous"   => false
    })
  end
end