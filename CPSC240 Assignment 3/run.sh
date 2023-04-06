#!/bin/bash

#Program: Array magnitude and append calculator
#Author: Kenneth Tran

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assemble fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assemble show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Compile compar.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o quick_sort.o quick_sort.cc

echo "Compile main.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o main.o main.cc

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o arrayMagnitudeAppend.out executive.o fill_random_array.o show_array.o quick_sort.o main.o -std=c++17

echo "Run the Array Program:"
./arrayMagnitudeAppend.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
