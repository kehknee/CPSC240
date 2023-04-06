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
//  Program name: main.cc
//  Programming languages: Three modules in X86, two modules in C
//  Date program began: 2023 Mar 5
//  Date of last update: 2023 Mar 9
//  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.cc, quick_sort.cc
//  Status: Finished.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

#include <string>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" char* executive(); // assembly module that will direct calls to other functions
                         // that will fill an array and add its contents

int main()
{
  printf("Welcome to Random Products, LLC.\n");
  printf("This software is maintained by Kenneth Tran\n");
  const char* name = executive();
  printf("Oh, %s .  We hope you enjoyed your arrays.  Do come again.\n", name);
  printf("A zero will be returned to the operating system.\n");
}
