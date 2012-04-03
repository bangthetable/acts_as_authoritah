describe ActsAsAuthoritah::Core do
  before :each do 
    class Foo
      include ActsAsAuthoritah::Core
      acts_as_authoritah
    end
  end
  
  it "should work" do
  end
  
  it "should be able to use 'can?' on instance of Foo class" do
    Foo.new.respond_to?('can?').should eq true
  end
end