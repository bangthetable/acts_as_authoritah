class ActsAsAuthoritah::Matchers::ScopeMatcher 
  def initialize(store)
    @store = store
  end
  
  def match(identifier)
    scopes = ActsAsAuthoritah::IdentifierParser.new(identifier).scopes
    scopes.length.times do |i|
      key = scopes[0..scopes.length-(i+1)].join("::")
      val = @store[key]
      return val if val
    end
    nil
  end
end