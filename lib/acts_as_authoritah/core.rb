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
       def can?
       end
     end
     
     module ClassMethods
       def acts_as_authoritah
       end
     end
  end
end

