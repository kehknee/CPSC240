#!/bin/bash

#Program: Electric Circuits Program
#Author: Kenneth Tran

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble circuits.asm"
nasm -f elf64 -l circuits.lis -o circuits.o circuits.asm

echo "Assemble getfrequency.asm"
nasm -f elf64 -l getfrequency.lis -o getfrequency.o getfrequency.asm

echo "Compile main.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o main.o main.cc

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o outputFile.out circuits.o getfrequency.o main.o -std=c++17

echo "Execute:\n"
./outputFile.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
