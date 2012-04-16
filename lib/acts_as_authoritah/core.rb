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
         context = (options[:context] && options[:context] != '') ? options[:context] : 'default'
         raise ActsAsAuthoritah::InvalidContextError, "'#{context}' is not a valid context" unless klass.valid_contexts.include?(context)
         h = klass.send(:get_acl, context.to_sym).match_identifier(identifier)
         h.empty? ? !klass.send(:whitelist) : h[self.usertype(options)]
       end
     end
     
     module ClassMethods
       def acts_as_authoritah(path, options={})
         @@whitelist = options[:whitelist] ||= false
         loader = ActsAsAuthoritah::AclLoader.new(path)
         @@contexts = loader.contexts
         @@acls = loader.load  
       end
       
       def valid_contexts
         @@contexts
       end
       
       def get_acl(key = :default)
         h = @@acls[key]
         h = @@acls[:default].clone.merge!(@@acls[key]) unless key.eql?(:default)
         h
       end
       
       def whitelist
         @@whitelist
       end
     end
  end
end

