#!/bin/bash

# $1 is the script, $2 is an optional argument to that script
echo "reference:"
python ./reference-interpreters/brainfuck.py $1 $2
echo 
echo "ruby:"
ruby ../brainfuck-interpreter.rb $1 $2
echo
