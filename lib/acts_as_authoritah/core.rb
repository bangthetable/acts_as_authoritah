module ActsAsAuthoritah
  module Core
     def self.included(base)
       base.send :include, ActsAsAuthoritah::Core::InstanceMethods
       base.extend ActsAsAuthoritah::Core::ClassMethods
     end
  end
end


module ActsAsAuthoritah
  module Core
     module InstanceMethods
       def can?(identifier, options={})
         klass = self.class
         klass.send(:default_acl).match_identifier(identifier)[self.usertype] ||= klass.send(:whitelist)
       end
     end
     
     module ClassMethods
       def acts_as_authoritah(path, options={})
         rules = ActsAsAuthoritah::SpreadsheetWrapper.new(path).to_access_rules
         @@whitelist = options[:whitelist] ||= false
         @@default_acl = ActsAsAuthoritah::AccessControlList.new(rules)
       end
       
       def default_acl
         @@default_acl ||= ActsAsAuthoritah::AccessControlList.new(rules)
       end
       
       def whitelist
         !@@whitelist
       end
     end
  end
end

