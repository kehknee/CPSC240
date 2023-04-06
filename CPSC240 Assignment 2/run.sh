#!/bin/bash

#Program: Array magnitude and append calculator
#Author: Kenneth Tran

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "Assemble append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "Compile display_array.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cc

echo "Compile main.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o main.o main.cc

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o arrayMagnitudeAppend.out manager.o input_array.o magnitude.o append.o main.o display_array.o -std=c++17

echo "Run the Array Program:"
./arrayMagnitudeAppend.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
