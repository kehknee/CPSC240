//****************************************************************************************************************************
// Program name: "main".  This program takes in the user input of height and width in float and calculates the hypotenuse
// Copyright (C) 2023 Kenneth Tran.                                                                                          *
//                                                                                                                           *
// This file is part of the software program "manager".                                                                   *
// Driver is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// Driver is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
// Author information
//  Author name: Kenneth Tran
//  Author email: kqmtran@csu.fullerton.edu
//
// Program information
//  Program name: Kenneth Tran
//  Programming languages: One modules in C++ and two modules in X86
//  Date program began: 2023 Apr 06
//  Date of last update: 2023 Apr 12
//  Files in this program: main.cc, manager.asm, getradicand.asm
//  Status: Finished.
//
//
// This file
//   File name: main.cc
//   Language: C
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o main.o main.cc
//   Link: g++ -m64 -no-pie -o outputFile.out manager.o get_clock_freq.o getradicand.o main.o -std=c++17
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

#include <stdio.h>
#include <stdint.h> //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>
#include <iostream>
#include <iomanip>
#include <math.h>

extern "C" double manager();

using namespace std;

int main(int argc, char* argv[])
{

  double nanoseconds = 0.0;
  nanoseconds = manager(); // calls assembly file to do calculations

  //gets value from assembly file and displays it
  printf("\n");
  printf("The main function has received this number %.5lf and will keep it for future reference.\n", nanoseconds);
  printf("The main function will return a zero to the operating system.");
  printf("\n");
  return 0;
}
