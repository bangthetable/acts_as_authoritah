class ActsAsAuthoritah::AccessRightsMapper
  def initialize(roles, access_rights)
    @roles = roles
    @access_rights = access_rights
  end
  
  def map
    h = {}
    @roles.each_with_index do |role, i|
      h[role] = @access_rights[i]
    end
    h
  end
end