# Ruby 2.3.1
# takes one command-line argument: name of file to interpret

class State
  attr_accessor :tape, :instruction_pointer, :data_pointer
  def initialize
    @tape = [nil] * 30000
    @data_pointer = 0
    @instruction_pointer = 0
  end
end

to_interpret = ARGV[0]



# we could load an entire bf file into memory, but that's bad form:
# e.g. assume we get a 5gb bf file (unlikely, but possible).
script = IO.readlines(to_interpret)
print script
#IO.foreach(to_interpret) do |line|
#  puts line
#end
