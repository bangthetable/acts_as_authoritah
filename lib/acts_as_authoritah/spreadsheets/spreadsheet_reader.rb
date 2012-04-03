class ActsAsAuthoritah::SpreadsheetReader
  def initialize(path)
    if File.exists?(path)
      @book  = Spreadsheet.open path
      @sheet = @book.worksheets.first
    else
      @error = "File not found"
    end
  end
  
  def valid?
    @error.nil?
  end
  
  def valid_rows
    i = 0
    rows = []
    @sheet.each{|row|
      i = i + 1
      next if i == 1
      row = row.to_a
      rows << row unless row.compact.empty?
    }
    rows
  end
  
  def header
    i = 0
    rows = []
    @sheet.each{|row|
      i = i + 1
      break if i > 1
      rows << row.to_a
    }
    rows.first
  end
end