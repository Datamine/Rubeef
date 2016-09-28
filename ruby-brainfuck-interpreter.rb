# Ruby 2.3.1
# takes one command-line argument: name of file to interpret

class State
  attr_accessor :tape, :instruction_pointer, :data_pointer, :script
  def initialize(script)
    @tape = [nil] * 30000
    @data_pointer = 0
    @instruction_pointer = 0
    @script = script
    @EOF = script.length
  end

  def interpret
    while instruction_pointer < @EOF do
      ...
    end
  end
end

brainfuck_not_allowed_regex = /[^(>|<|\+|\-|\.|,|\]|\[)]/
to_interpret = ARGV[0]

# read the script into memory, strip it of cruft, join the string.
script_text = IO.readlines(to_interpret).map(&:strip).join(' ')
script_text.gsub!(brainfuck_not_allowed_regex, "")

interpreter_instance = State.new(script)
interpreter_instane.interpret
