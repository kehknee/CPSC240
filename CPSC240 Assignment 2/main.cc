//****************************************************************************************************************************
// Program name: "main".  This is the main program built in C for the magnitude and appending of two arrays
// Copyright (C) 2023 Kenneth Tran.                                                                                          *
//                                                                                                                           *
// This file is part of the software program "pythagoras".                                                                   *
// main is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// main is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//  Programming languages: Two modules in C and three module in X86
//  Date program began: 2023 Feb 10
//  Date of last update: 2023 Feb 19
//  Files in this program: manager.asm, append.asm, magnitude.asm, input_array.asm, display.cc, main.cc
//  Status: Finished.
//
//
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double manager(); // assembly module that will direct calls to other functions
                         // that will fill an array and add its contents

int main(int argc, char *argv[])
{
  printf("Welcome to Arrays of Integers\n");
  printf("Brought to you by Kenneth Tran\n");
  printf("\n");
  double answer = manager(); // the control module will return the sum of the array contents
  printf("The main has received this number %.10lf and will keep it for future use.\n", answer);
  printf("Main will return 0 to the operating system.   Bye.\n");
}
