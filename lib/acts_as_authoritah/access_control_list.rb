require "acts_as_authoritah/matchers/direct_matcher.rb"
require "acts_as_authoritah/matchers/controller_matcher.rb"
require "acts_as_authoritah/matchers/scope_matcher.rb"


class ActsAsAuthoritah::AccessControlList
  include ActsAsAuthoritah::Matchers

  attr_accessor :store

  def initialize(access_rules)
    @store = {}
    access_rules.each do |access_rule|
      @store.merge! access_rule.to_rule
    end

    @matchers = [DirectMatcher, ControllerMatcher, ScopeMatcher]
  end

  def match(identifier)
    @matchers.each do |matcher|
      access_rights = matcher.new(@store).match(identifier)
      return access_rights unless access_rights.nil?
    end
    nil
  end

  def match_identifier(identifier)
    match(identifier) || {}
  end

  def merge(other_access_control_list)
    a = self.deep_clone
    a.store.merge!(other_access_control_list.store)
    a
  end

  def deep_clone
    Marshal::load(Marshal.dump(self))
  end

end
