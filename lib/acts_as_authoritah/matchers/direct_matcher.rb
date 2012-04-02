class ActsAsAuthoritah::Matchers::DirectMatcher
  def initialize(store)
    @store = store
  end  

  def match(identifier)
    @store[identifier]
  end
end