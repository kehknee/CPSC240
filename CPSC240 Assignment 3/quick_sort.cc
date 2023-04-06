//****************************************************************************************************************************
// Program name: "quick_sort.cc".
// Copyright (C) 2023 Kenneth Tran.                                                                                          *
//                                                                                                                           *
// This file is part of the software program "quick_sort".                                                                   *
// quick_sort is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// quick_sort is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//  Program name: quick_sort.cc
//  Programming languages: Three modules in X86, two modules in C
//  Date program began: 2023 Mar 5
//  Date of last update: 2023 Mar 9
//  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.cc, quick_sort.cc
//  Status: Finished.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

#include <stdbool.h>

extern "C" int quick_sort(const void *a, const void *b);

int quick_sort(const void *a, const void *b)
{
  if(*(double*)a > *(double*)b){
    return 1;
  }

  if (*(double *)a < *(double *)b){
    return -1;
  }

  return 0;
}
