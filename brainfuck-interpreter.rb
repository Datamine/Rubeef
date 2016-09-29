# Ruby 2.3.1
# takes one command-line argument: name of file to interpret

require 'io/console'

class State
  @@tape_length = 30000
  def initialize(script)
    @tape = [0] * @@tape_length
    @data_pointer = 0
    @instruction_pointer = 0
    @script = script
    @script_length = script.length
  end

  def interpret
    while valid_state do
      command = @script[@instruction_pointer]
      # nb: a statistical ordered approach to minimize if-statements would be wise
      # should i use case/switch here?
      if command == "+"
        # think i need to do byte-wise increment, not numerical
        @tape[@data_pointer] += 1
      elsif command == "-"
        @tape[@data_pointer] -= 1
      elsif command == ">"
        @data_pointer += 1
      elsif command == "<"
        @data_pointer -= 1
      elsif command == "."
        print @tape[@data_pointer]
      elsif command == ","
        input = STDIN.getch
        if input == chr(26)
          # handle EOF
          input = 0
        else
          input = input
        end
        @tape[@data_pointer] = input
      elsif command == "["
        if @tape[@data_pointer] == 0
          # skip to the next "]", unless it cannot be found (then break).
          begin
            while @script[@instruction_pointer] != "]"
              @instruction_pointer += 1
            end
            next
          rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
            exit(false)
          end
        end
      else
        # the command == "]" case
        unless @tape[@data_pointer] == 0
          # skip to the previous "[", unless it cannot be found (then break).
          begin
            while @script[@instruction_pointer] != "["
              @instruction_pointer -= 1
            end
            next
          rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
            exit(false)
          end
        end
      end
      @instruction_pointer += 1
    end
  end
  def valid_state
    # check that the current state of the program is valid, given bf rules
    return (0 <= @data_pointer) && (@data_pointer < @@tape_length) && (@instruction_pointer < @script_length)
  end
end

brainfuck_not_allowed_regex = /[^(>|<|\+|\-|\.|,|\]|\[)]/
to_interpret = ARGV[0]

# read the script into memory, strip it of cruft, join the string.
script_text = IO.readlines(to_interpret).map(&:strip).join(' ')
script_text.gsub!(brainfuck_not_allowed_regex, "")

interpreter_instance = State.new(script_text)
interpreter_instance.interpret
