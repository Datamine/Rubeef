# Ruby 2.3.1
# takes one command-line argument: name of file to interpret

class State
  def initialize(script)
    @tape = [0]
    @data_pointer = 0
    @instruction_pointer = 0
    @script = script
    @script_length = script.length
    @jumps = precompute_jumps
  end

  def precompute_jumps
    stack = []
    jumphash = {}
    instruction_pointer = 0
    while instruction_pointer < @script_length
      command = @script[instruction_pointer]
      case command
      when "["
        stack << instruction_pointer
      when "]"
        target = stack.pop
        jumphash[target] = instruction_pointer
        jumphash[instruction_pointer] = target
      end
      instruction_pointer += 1
    end
    return jumphash
  end

  def valid_state
    # check that the current state of the program is valid, given bf rules
    return (0 <= @data_pointer) && (@data_pointer < @tape.length) &&
           (0 <= @instruction_pointer) && (@instruction_pointer < @script_length)
  end

  def interpret
    while valid_state do
      command = @script[@instruction_pointer]
      #print "#{command} #{@instruction_pointer} #{@data_pointer} #{@tape}\n"
      case command
      when "+"
        @tape[@data_pointer] += 1
      when "-"
        @tape[@data_pointer] -= 1
      when ">"
        @data_pointer += 1
        if @data_pointer == @tape.length
          @tape << 0
        end
      when "<"
        @data_pointer -= 1
      when "."
        print @tape[@data_pointer].chr
      when ","
        input = STDIN.read(1).ord
        if input==13
          # Most bf scripts assume that the enter key is represented by ASCII 10.
          # (This may not always be the case.)
          input = 10
        elsif input==3
          exit()
        end
        @tape[@data_pointer] = input
      when "["
        if @tape[@data_pointer] == 0
          @instruction_pointer = @jumps[@instruction_pointer]
        end
      when "]"
        if @tape[@data_pointer] != 0
          @instruction_pointer = @jumps[@instruction_pointer]
          end
      end
      @instruction_pointer += 1
    end
  end
end

brainfuck_not_allowed_regex = /[^>|<|\+|\-|\.|,|\]|\[]/
to_interpret = ARGV[0]

# read the script into memory, strip it of cruft, join the string.
script_text = IO.readlines(to_interpret).map(&:strip).join(' ')
script_text.gsub!(brainfuck_not_allowed_regex, "")

interpreter_instance = State.new(script_text)
interpreter_instance.interpret
