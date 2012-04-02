class AccessRule
  attr_reader :identifier, :description, :access_rights
  
  def initialize(identifier, description, access_rights)
    @identifier    = identifier
    @description   = description
    @access_rights = access_rights
  end
  
  def action
    return nil if @identifier.nil?
    return nil unless @identifier.include?("#")
    return nil if @identifier.split('').last == '#'
    @identifier.split("#").last
  end
  
  def controller
    return nil if @identifier.nil?
    return nil if @identifier == ""
    return @identifier.split('#').first
  end
  
  def scopes
    return [] if @identifier.nil?
    return [] if @identifier == ""
    arr = @identifier.split('::')
    arr.length > 1 ? arr[0..-2] : []
  end
  
end