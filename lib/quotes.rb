# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes

  attr_reader :file
  attr_reader :params
  attr_reader :line

  def initialize(file)
    file.each { |k,v| @file = v}
  end

  def find(line)
    return "Could not find a quote at this time" unless File.exist?(@file)
    line_count = 0
    File.open(@file) {|f| line_count = f.read.count("\n")}
    line = Random.rand(line_count + 1) if line > line_count
    text = File.open(@file).readlines
    quote = text[line].chomp 
    return quote
  end

  def all

   results = []

    File.open(@file) do |f|
      f.each do |line|
        line.chomp!
        results << line
      end
    end    
    return results
  end

  def quotes
    results = all
  end

  def search(params ={})
    results = []
    return results  unless File.exist?(@file)
    
    quotes.map do |quote|
       params.empty? ? quote : params.map {|key,value| quote if quote.send("#{key}?", value) }.uniq
    end.flatten.compact
  end

  alias :[] :find
end

