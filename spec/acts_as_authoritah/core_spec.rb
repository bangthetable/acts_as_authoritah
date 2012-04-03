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
    Foo.new.should respond_to('can?')
  end
end