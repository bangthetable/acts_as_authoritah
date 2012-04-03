class ActsAsAuthoritah::SpreadsheetWrapper
  def initialize(path)
    spreadsheet_reader = ActsAsAuthoritah::SpreadsheetReader.new(path)
    @roles = ActsAsAuthoritah::SpreadsheetHeaderParser.new(spreadsheet_reader.header).roles
    @rows  = spreadsheet_reader.valid_rows.collect{|row| ActsAsAuthoritah::SpreadsheetRowParser.new(row)}
  end
  
  def to_access_rules
    access_rules = []
    @rows.each do |row|
      mapped_access_rights = ActsAsAuthoritah::AccessRightsMapper.new(@roles, row.access_rights).map
      access_rules << ActsAsAuthoritah::AccessRule.new(row.scope, row.controller, row.action, mapped_access_rights)
    end
    access_rules
  end
end