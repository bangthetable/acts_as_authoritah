class ActsAsAuthoritah::Matchers::ControllerMatcher 
  def initialize(store)
    @store = store
  end
  
  def match(identifier)
    controller = ActsAsAuthoritah::IdentifierParser.new(identifier).controller
    @store[controller]
  end
end