;****************************************************************************************************************************
;Program name: "show_array".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "show_array".                                                                   *
;show_array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;show_array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Kenneth Tran
;  Author email: kqmtran@csu.fullerton.edu
;
;Program information
;  Program name: show_array
;  Programming languages: Three modules in X86, two modules in C
;  Date program began: 2023 Mar 5
;  Date of last update: 2023 Mar 9
;
;  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.cc, quick_sort.cc
;  Status: Finished.
;
;===== Begin code area ================================================================================================

extern printf
extern scanf

global show_array

segment .data

float_format db "0x%016lx      %-18.13e", 10, 0

label_of_numbers db "IEEE754			Scientific Decimal", 10, 0

segment .bss

segment .text

show_array:
;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp, rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0

;Registers rax, rip, and rsp are usually not backed up.

; =================== REGISTER ARRAY ============================

mov r13, rdi    ;array name
mov r14, rsi    ;array size
mov r15, 0      ;index

; =================== PRINT LABELS ============================

push qword 0
mov rax, 0
mov rdi, label_of_numbers       ;"IEEE754			Scientific Decimal"
call printf
pop rax

; =================== LOOP TO GENERATE RANDOM NUMBERS AND INPUT INTO ARRAY ============================

loopStart:
  cmp r15, r14 ;check if index is equal / if yes, jump to end of loop, if not continue
  je loopEnd

  push qword 0
  mov rax, 1
  mov rdi, float_format
  mov rsi, [r13 + 8*r15]
  movsd xmm0, [r13 + 8*r15]
  call printf
  pop rax

  inc r15
  jmp loopStart

loopEnd:

pop rax

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret
