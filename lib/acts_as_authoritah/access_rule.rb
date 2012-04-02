class ActsAsAuthoritah::AccessRule
  attr_reader :scope, :controller, :action, :access_rights
  
  def initialize(scope, controller, action, access_rights)
    @scope = scope
    @controller = controller
    @action = action
    @access_rights = access_rights
  end
  
  def action?
    @action && @action != ""
  end
  
  def controller?
    @controller && @controller != ""
  end
  
  def scope?
    @scope && @scope != ""
  end
  
  def to_rule
    key = ""
    key += @scope if scope?
    key += "::#{@controller}Controller" if controller?
    key += "##{action}" if action?
    { key => access_rights }
  end
end