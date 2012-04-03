class ActsAsAuthoritah::SpreadsheetHeaderParser
  def initialize(header_row)
    @header_row = header_row
  end
  
  def roles
    @header_row[4..-1]
  end
end