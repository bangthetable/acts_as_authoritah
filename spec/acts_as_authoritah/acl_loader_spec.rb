require 'spec_helper'

describe ActsAsAuthoritah::AclLoader do
  before :each do
    @acl_loader = ActsAsAuthoritah::AclLoader.new("spec/data/")
    @acl_loader.load
  end
  
  it "should be able to get the list of contexts" do
    @acl_loader.contexts.should eq ["archived", "default", "unpublished"]
  end
  
  it "should load the rules of 'archived' context" do
    archived_rules = {"scope1::scope2::DummyController#edit"=>{"admin"=>true, "anonymous"=>false, "super_admin"=>true}, "scope3::scope4::AnotherController#update"=>{"admin"=>true, "anonymous"=>true, "super_admin"=>true}}
    @acl_loader.acls[:archived].store.should eq archived_rules
  end
  
  it "should load all contexts" do
    @acl_loader.acls.keys.size.should eq 3
  end
end