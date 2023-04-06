//****************************************************************************************************************************
// Program name: "display_array".
// Copyright (C) 2023 Kenneth Tran.                                                                                          *
//                                                                                                                           *
// This file is part of the software program "display_array".                                                                   *
// display_array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// display_array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

#include <iostream>

extern "C" void display_array(double arr[], int arr_size);

using namespace std;

void display_array(double arr[], int arr_size)
{
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.10lf   ", arr[i]);
  }
}
