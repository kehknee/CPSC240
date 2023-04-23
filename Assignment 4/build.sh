#!/bin/bash

#Program: Tics and Nanoseconds program
#Author: Kenneth Tran

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble getradicand.asm"
nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm

echo "Compile main.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o main.o main.cc

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o outputFile.out manager.o getradicand.o main.o -std=c++17

echo "Execute:"
./outputFile.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
