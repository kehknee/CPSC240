#!/bin/bash

#Program: Hypotenuse Calculator
#Author: Kenneth Tran

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble hypotenuse.asm"
nasm -f elf64 -l pythagoras.lis -o pythagoras.o pythagoras.asm

echo "Compile triangle.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cc

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o pythagoras-final.out driver.o pythagoras.o -std=c++17

echo "Run the Hypotenuse Calculator:"
./pythagoras-final.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
