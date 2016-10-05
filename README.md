## Brainfuck interpreter in Ruby

Run with `ruby brainfuck-interpreter.rb <path to your bf script here>`

Some tests included, use `./runtest.sh <path to bf script in testscripts>` to run the
ruby interpretation against one of the reference interpreters.

## Interesting things I learned:

If you process input using `require 'io/console'` and `STDIN.getch`, the enter/return
key (at least on OS X) is parsed as ASCII 13. If you use `STDIN.read(1)`, it's parsed
as ASCII 10. Same in python for `sys.stdin.read(1)`. This threw me off while trying
to handle input properly. Most bf scripts seem to be written to accommodate only 
ASCII 10 as a newline indicator, not ASCII 13 as well (and feeding in one when the 
script expects the other can result in all kinds of strange bugs).

## Credits:

- Python reference versions from https://github.com/pablojorge/brainfuck
- Test scripts from that repository as well, except for the following:
- `squares.bf` by [Daniel B Cristofani](http://www.hevanet.com/cristofd/brainfuck/)
- `a.bf` and `multiply.bf` from [LearnXinYminutes](https://learnxinyminutes.com/docs/bf/). Note that `multiply.bf` doesn't seem to work at the command line. It works in this [bf visualizer](https://fatiherikli.github.io/brainfuck-visualizer/#), so I'm not sure what's up with that.
