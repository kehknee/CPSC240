;****************************************************************************************************************************
;Program name: "input_array".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "input_array".                                                                   *
;input_array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;input_array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: input_array
;  Programming languages: Two modules in C and three module in X86
;  Date program began: 2023 Feb 10
;  Date of last update: 2023 Feb 19
;
;  Files in this program: manager.asm, append.asm, magnitude.asm, input_array.asm, display.cc, main.cc
;  Status: Finished.
;
;===== Begin code area ================================================================================================

extern printf
extern scanf

extern stdin
extern clearerr

global input_array

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

float_format db "%lf", 0

segment .bss

segment .text

input_array:
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

mov r15, rdi    ;array name
mov r14, rsi    ;array size

; =================== LOOP TO ENTER NUMBERS IN ARRAY ============================

mov r13, 0
loopStart:
  cmp r14, r13 ;check if index is equal / if yes, jump to end of loop, if not continue
  je loopEnd
  mov rax, 0
  mov rdi, float_format

  push qword 0
  mov rsi, rsp    ;takes user input
  call scanf

  cdqe
  cmp rax, -1       ;checks if ctrl + d is pressed

  pop r12       ;if yes, go to end of loop, if not continue
  je loopEnd
  mov [r15 + 8*r13], r12  ;move r12 (number from user) into r15 (stored array) at index r13
  inc r13
  jmp loopStart

loopEnd:

push qword 0
mov rax, 0
mov rdi, [stdin]      ;clear bits
call clearerr
pop rax

pop rax
mov rax, r13

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
