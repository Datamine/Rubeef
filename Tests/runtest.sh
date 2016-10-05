#!/bin/bash

# $1 is the script path
if [ -z $1 ]
then
  echo "Error! No script to test was supplied."
  exit 1
fi
echo "reference:"
python ./reference-interpreters/brainfuck-simple.py $1
echo 
echo "ruby:"
ruby ../brainfuck-interpreter.rb $1
echo
