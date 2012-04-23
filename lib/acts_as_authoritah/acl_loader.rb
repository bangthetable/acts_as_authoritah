class ActsAsAuthoritah::AclLoader 
  attr_reader :contexts, :acls
  
  def initialize(path)
    @path = path
    @files = []
    @contexts = []
    Dir.glob(File.join(@path,"*.csv")).each{ |x|
      @files    << x
      @contexts << File.split(x).last.split('.').first
    }
    @acls = {}
  end
  
  def load
    @files.each_with_index do |file, i|
      context = @contexts[i]
      rules   = ActsAsAuthoritah::SpreadsheetWrapper.new(file).to_access_rules
      @acls[context.to_sym] = ActsAsAuthoritah::AccessControlList.new(rules)
    end
    @acls
  end
end