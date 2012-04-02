require "acts_as_authoritah/matchers/direct_matcher.rb"
require "acts_as_authoritah/matchers/controller_matcher.rb"
require "acts_as_authoritah/matchers/scope_matcher.rb"


class ActsAsAuthoritah::AccessControlList
  include ActsAsAuthoritah::Matchers
  
  attr_reader :store
  
  def initialize(access_rules)
    @store = {}
    access_rules.each do |access_rule|
      @store.merge access_rule.to_rule
    end
    
    @matchers = [DirectMatcher, ControllerMatcher]
  end
  
  def match(identfier)
    @matchers.each do |matcher|
      access_rights = matcher.match(@store, identifier)
      return access_rights unless access_rights.nil?
    end
    return {}
  end
  
end