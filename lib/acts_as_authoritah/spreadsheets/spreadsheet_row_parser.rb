class ActsAsAuthoritah::SpreadsheetRowParser
  def initialize(row)
    @row = row
  end
  
  def scope
    @row[0]
  end
  
  def controller
    @row[1]
  end
  
  def action
    @row[2]
  end
  
  def access_rights
    @row[4..-1].collect{|x|
      x == 'x' || x == "X" || x == "*"
    }
  end
end