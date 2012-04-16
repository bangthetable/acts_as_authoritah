require 'spec_helper'

describe ActsAsAuthoritah::Core do
  before :each do 
    class Foo
      include ActsAsAuthoritah::Core
      acts_as_authoritah "spec/data"
      
      def usertype(options)
        "admin"
      end
    end
  end
  
  it "should be able to use 'can?' on instance of Foo class" do
    Foo.new.should respond_to('can?')
  end
  
  it "should be able to add 'get_acl' method to Foo class" do
    Foo.should respond_to('get_acl')
  end
  
  it "should be able to get the default acl" do
    Foo.get_acl(:default).should_not be_nil
  end
  
  it "should be able to use 'can?' on Foo to check access rights - case1" do
    Foo.new.can?("scope1::scope2::DummyController#edit").should eq true
  end
  
  it "should be able to use 'can?' on Foo to check access rights - case2" do
    Foo.new.can?("scope3::scope4::AnotherController#update").should eq false
  end
  
  it "should be able to use 'can?' with a context on Foo to check access rights - case3" do
    Foo.new.can?("scope3::scope4::AnotherController#update", :context => 'archived').should eq true
  end
  
  it "should know the valid contexts" do
    Foo.should respond_to('valid_contexts')
    Foo.valid_contexts.should eq ["archived", "default", "unpublished"]
  end
  
  it "should raise 'InvalidContextError' if an invalid context is passed" do
    lambda{
      Foo.new.can?("scope3::scope4::AnotherController#update", :context => 'foobar')
    }.should raise_error(ActsAsAuthoritah::InvalidContextError, "'foobar' is not a valid context")
  end

  context "whitelist=false" do
    before :each do
      class Foo
        include ActsAsAuthoritah::Core
        acts_as_authoritah "spec/data", :whitelist => false
      
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
        acts_as_authoritah "spec/data", :whitelist => true
      
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