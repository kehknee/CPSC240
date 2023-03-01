//****************************************************************************************************************************
// Program name: "driver".  This program takes in the user input of height and width in float and calculates the hypotenuse
// Copyright (C) 2023 Kenneth Tran.                                                                                          *
//                                                                                                                           *
// This file is part of the software program "pythagoras".                                                                   *
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
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2023 Jan 25
//  Date of last update: 2023 Feb 1
//  Files in this program: triangle.cc, hypotenuse.asm
//  Status: Finished.
//
//
// This file
//   File name: driver.cc
//   Language: C
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o triangle.o triangle.cc
//   Link: g++ -m64 -no-pie -o hypotenuse-final.out triangle.o hypotenuse.o -std=c++17
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

extern "C" double hypotenuse();

using namespace std;

int main(int argc, char* argv[])
{

  //prompt for welcome message and email
  printf("Welcome to Pythagoras programmed by Kenneth Tran.\n");
  printf("Please contact kqmtran@csu.fullerton.edu if you need assistance.");
  printf("\n");

  double length = 0.0;
  length = hypotenuse();    //calls assembly file to do calculations

  //gets value from assembly file and displays it
  printf("\n");
  printf("The main function has received the number %.12lf and will keep it for now.\n", length);
  printf("We hope you enjoyed your right angles. Have a good day. A zero will be sent to your operating system.\n");
  return 0;
}
