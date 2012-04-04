require 'spec_helper'

describe ActsAsAuthoritah::Core do
  before :each do 
    class Foo
      include ActsAsAuthoritah::Core
      acts_as_authoritah "spec/data/default.xls"
      
      def usertype(options)
        "admin"
      end
    end
  end
  
  it "should work" do
  end
  
  it "should be able to use 'can?' on instance of Foo class" do
    Foo.new.should respond_to('can?')
  end
  
  it "should be able to add 'default_acl' method to Foo class" do
    Foo.should respond_to('default_acl')
  end
  
  it "should be able to use 'can?' on Foo to check access rights - case1" do
    Foo.new.can?("scope1::scope2::DummyController#edit").should eq true
  end
  
  context "whitelist=false" do
    before :each do
      class Foo
        include ActsAsAuthoritah::Core
        acts_as_authoritah "spec/data/default.xls", :whitelist => false
      
        def usertype(options)
          "admin"
        end
      end
    end
    
    it "can? should return true when a matching rule is not found" do
      Foo.new.can?("DummyController#edit").should eq true
    end
  end
  
  context "whitelist=true" do
    before :each do
      class Foo
        include ActsAsAuthoritah::Core
        acts_as_authoritah "spec/data/default.xls", :whitelist => true
      
        def usertype(options)
          "admin"
        end
      end
    end
    
    it "can? should return false when a matching rule is not found" do
      Foo.new.can?("DummyController#edit").should eq false
    end
  end


end